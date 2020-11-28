<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--这里的utf-8是指服务器发送给客服端时的内容编码 --%>
<%@ page pageEncoding="utf-8" %>
<%--这里的utf-8是指 .jsp文件本身的内容编码 --%>
<html>
<head>
    <title>员工列表</title>
    <script src="${pageContext.request.contextPath}/static/jQuery/jquery-3.5.1.min.js"></script>
    <%-- 引入bootstrap --%>
    <link href="${pageContext.request.contextPath}/static/bootstrap-4.5.0/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/static/bootstrap-4.5.0/js/bootstrap.min.js"></script>
    <script>
        var totalRecord; // 记录总的数据个数
        var reEmpName; // 姓名是否重复
        var currentPage; // 当前页
        $(()=>{
            getList(1);
            // 新增按钮
            $("#addEmp").click(function (){
                // 获取部门信息
                getDepts("#dId");
                // 弹出模态框
                $('#empAddModal').modal({
                    backdrop:'static'
                });
            });

            // 检验用户名是否重复
            $("#empName").change(function (){
                var empName = this.value;
                $.ajax({
                    url:"${pageContext.request.contextPath}/checkUser",
                    type:"get",
                    data:"empName="+empName,
                    success:function (data) {
                        console.log(data);
                        if ($("#empName").val()=="") { return; }
                        if (data.code==100) {
                            reEmpName = false; // 记录不重复
                            show_validate_msg("#empName","success","");
                        } else {
                            reEmpName = true; // 记录重复
                            show_validate_msg("#empName","error",data.data.va_msg);
                        }
                    }
                });
            });

            // 员工信息数据验证
            function validate_add_form() {
                // 名称校验
                var empName = $("#empName").val();
                var regName =  /(^[a-zA-Z0-9]{4,12}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
                if(!regName.test(empName)){
                    show_validate_msg("#empName","error","名字格式有误,可以是2-5位中文或4-12位英文和数字的组合");
                    return false;
                } else {
                    show_validate_msg("#empName","success","");
                }
                // 邮箱校验
                var email = $("#email").val();
                var regEmail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#email","error","邮箱输入格式有误");
                    return false;
                } else {
                    show_validate_msg("#email","success","");
                }
                return true;
            }

            // 保存员工信息按钮
            $("#save").click(function (){
                console.log("员工信息："+$("#emp_form").serialize());
                // 数据验证
                if (reEmpName) { return; }
                if (!validate_add_form()) { return; }
                // 向服务器发送新增员工信息
                $.ajax({
                    url:"${pageContext.request.contextPath}/emp",
                    type: "post",
                    data: $("#emp_form").serialize(),
                    success:function (data){
                        if (data.code==100){
                            alert("员工信息添加成功");
                            // 关闭模态框
                            $('#empAddModal').modal("hide");
                            // 跳转到最后一页
                            getList(totalRecord);
                            // 清理输入框
                            $("#empName").val("").removeClass("is-valid is-invalid").next("span").text("");
                            $("#email").val("").removeClass("is-valid is-invalid").next("span").text("");
                        } else {
                            if (undefined != data.data.errorFields.email) {
                                show_validate_msg("#email","error",data.data.errorFields.email);
                            }
                            if (undefined != data.data.errorFields.empName) {
                                show_validate_msg("#empName","error",data.data.errorFields.empName);
                            }
                            alert("员工信息添加失败");
                        }
                    }
                });
            });

            // 点击编辑按钮(修改员工信息)
            $(document).on("click",".edit_btn",function (){
                // 获取部门列表
                getDepts("#dIdUp");
                // 弹出修改员工模态框
                $('#empUpdateModal').modal({
                    backdrop:'static'
                });
                // 将员工id传递给保存按钮
                $("#saveUp").attr("empId",$(this).attr("empId"));
                // 查询员工信息并显示
                getEmp($(this).attr("empId"));
            });

            // 修改员工信息点击保存
            $("#saveUp").click(function () {
                // 邮箱校验
                var email = $("#emailUp").val();
                var regEmail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#emailUp","error","邮箱输入格式有误");
                    return false;
                } else {
                    show_validate_msg("#emailUp","success","");
                }
                // 发送请求更新员工信息
                $.ajax({
                    url:"${pageContext.request.contextPath}/emp/"+$(this).attr("empId"),
                    type:"PUT",
                    data:$("#emp_form_up").serialize(),
                    success:function (data) {
                        // console.log(data);
                        // 关闭模态框
                        $('#empUpdateModal').modal("hide");
                        // 返回本页
                        getList(currentPage)
                        // 清除邮箱输入框样式
                        $("#emailUp").val("").removeClass("is-valid is-invalid").next("span").text("");
                    }
                });
            });

            // 删除单个员工
            $(document).on("click",".delete_btn",function (){
                var empName = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("empId");
                if (confirm("确认删除【"+empName+"】吗？")) {
                    $.ajax({
                        url:"${pageContext.request.contextPath}/emp/"+empId,
                        type:"DELETE",
                        success:function (data) {
                            alert("删除【"+empName+"】成功！");
                            // 重新请求当前页
                            getList(currentPage);
                        }
                    });
                }
            });

            // 全选/全不选
            $("#check_all").click(function () {
                var all_checked = $(this).prop("checked");
                console.log("全选按钮："+all_checked);
                $(".check_item").prop("checked",all_checked);
            });
            //单选框
            $(document).on('click','.check_item',function () {
                var all_checked = ($(".check_item:checked").length ==
                    $(".check_item").length)
                $("#check_all").prop("checked",all_checked)
            });

            // 点击批量删除
            $("#delete_all_btn").click(function () {
                var empName = ""; // 删除的用户
                var empId = ""; // 删除的用户id
                $.each($(".check_item:checked"),function () {
                    empName += $(this).parents("tr").find("td:eq(2)").text()+",";
                    empId += $(this).parents("tr").find("td:eq(1)").text()+"-";
                })
                empName = empName.substring(0,empName.length-1);
                empId = empId.substring(0,empId.length-1);
                if (confirm("确认删除【"+empName+"】吗？")) {
                    $.ajax({
                        url:"${pageContext.request.contextPath}/emp/"+empId,
                        type:"DELETE",
                        success:function (data) {
                            alert("确认删除【"+empName+"】成功！")
                            getList(currentPage);
                        }
                    });
                }
            });
        });

        // 显示检验结果的提示信息
        function show_validate_msg(ele,status,msg) {
            // 清除当前状态
            $(ele).removeClass("is-valid is-invalid");
            $(ele).next("span").text("");
            if ("success"==status) {
                $(ele).addClass("is-valid");
                $(ele).next("span").text(msg);
            } else if ("error"==status) {
                $(ele).addClass("is-invalid");
                $(ele).next("span").text(msg);
            }
        }

      // 获取部门信息并显示在部门列表中
        function getDepts(ele){
            $.ajax({
                url:"${pageContext.request.contextPath}/depts",
                type:"get",
                success:function (data){
                    let depts = data.data.depts;
                    $(ele).empty();
                    depts.forEach(function (v){
                        let opt = $('<option></option>')
                            .append(v.deptName)
                            .attr("value",v.deptId);
                        opt.appendTo(ele);
                    });
                }
            });
        }

        // 获取列表数据
        function getList(pn){
            if (pn==0) return;
            $.get({
                // 请求地址
                url:"${pageContext.request.contextPath}/empsJson",
                // 携带数据
                data:{"pn":pn},
                // 请求成功函数，data参数为请求响应的数据
                success:function(data){
                    console.log(data);
                    show(data);
                },
                // 请求失败
                error:function (){
                    console.log("error");
                }
            });
        }

        // 操作数据DOM
        function show(data){
            let pageInfo = data.data.pageInfo;
            // 表数据
            let list = data.data.pageInfo.list;
            $("#tableBody").empty();
            for (let i = 0;i < list.length;i++){
                let checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
                let empId = $("<td></td>").append(list[i].empId);
                let empName = $("<td></td>").append(list[i].empName);
                let gender = $("<td></td>").append(list[i].gender=='1'?'男':'女');
                let email = $("<td></td>").append(list[i].email);
                let deptName = $("<td></td>").append(list[i].department.deptName);
                let edit = $("<button></button>").addClass("btn btn-outline-success btn-sm edit_btn")
                            .append($(`<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                                        </svg>`)).append("编辑");
                // 为编辑按钮添加自定义属性，存储它当前的员工id
                edit.attr("empId",list[i].empId);
                let dele = $("<button></button>").addClass("btn btn-outline-danger btn-sm delete_btn")
                            .attr("empId",list[i].empId)
                            .append($(`<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                        </svg>`)).append("删除");
                // 为删除按钮添加自定义属性，存储它当前的员工id
                edit.attr("empId",list[i].empId);
                let btnTd = $("<td></td>").append(edit).append(" ").append(dele);
                $("<tr></tr>").append(checkBoxTd).append(empId)
                .append(empName).append(gender)
                .append(email).append(deptName)
                .append(btnTd).appendTo("#tableBody");
            }

            // 记录当前页数
            currentPage = pageInfo.pageNum;

            // 页数据信息显示
            $("#pnInfo").empty();
            totalRecord = pageInfo.total; //记录总的数据个数
            let num = $("<span></span>").addClass("border border-success")
            .append(`当前 <span class="badge badge-success">`+currentPage+`</span> 页 `);
            let toalo = $("<span></span>").addClass("border border-danger")
            .append(`共 <span class="badge badge-danger">`+pageInfo.pages+`</span> 页 `);
            let n = $("<span></span>").addClass("border border-warning")
            .append(`共 <span class="badge badge-warning">`+totalRecord+`</span> 条数据 `);
            $("#pnInfo").append(num)
                .append(" | ").append(toalo)
                .append(" | ").append(n);

            // 页码显示
            let start = `
            <li class="page-item ${"${pageInfo.pageNum==1?'disabled':''}"}"
            onclick="getList(${"${pageInfo.pageNum==1?0:1}"})">
                <a class="page-link" href="#"}">首页</a>
            </li>
            <li class="page-item ${"${pageInfo.pageNum==1?'disabled':''}"}"
            onclick="getList(${"${pageInfo.pageNum==1?0:pageInfo.pageNum-1}"})">
                <a class="page-link" href="#"}"
                   aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            `;
            let end = `
            <li class="page-item ${"${pageInfo.pageNum==pageInfo.pages?'disabled':''}"}"
            onclick="getList(${"${pageInfo.pageNum==pageInfo.pages?0:pageInfo.pageNum+1}"})">
                <a class="page-link" href="#"
                   aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
            <li class="page-item ${"${pageInfo.pageNum==pageInfo.pages?'disabled':''}"}"
            onclick="getList(${"${pageInfo.pageNum==pageInfo.pages?0:pageInfo.pages}"})">
                <a class="page-link" href="#">尾页</a>
            </li>
            `;
            let nums = pageInfo.navigatepageNums;
            let center = "";
            for(let i = 0;i<nums.length;i++){
                center +=`
                    <li class="page-item ${"${pageInfo.pageNum==nums[i]?'active':''}"}"
                    onclick="getList(${"${nums[i]}"})">
                        <a class="page-link" href="#">${"${nums[i]}"}</a>
                    </li>
                `;
            }
           $("#pn").html(start + center + end);
        }

        // 获取员工信息
        function getEmp(id) {
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/"+id,
                type:"GET",
                success:function (data) {
                    var empName = data.data.emp.empName;
                    var email = data.data.emp.email;
                    var gender = data.data.emp.gender;
                    var dId = data.data.emp.dId;
                    console.log(data);
                    $("#empNameUp").text(empName);
                    $("#emailUp").val(email);
                    $("#empUpdateModal input[name=gender]").val([gender]);
                    $("#dIdUp").val([dId]);
                }
            });
        }

    </script>
</head>
<body>
<div class="container">
    <%-- 员工修改模态框 --%>
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabelUpdate" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabelUpdate">员工修改</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- 表单 --%>
                    <form id="emp_form_up">
                        <div class="form-group row">
                            <label for="empNameUp" class="col-sm-2 col-form-label">姓名</label>
                            <div class="col-sm-10">
                                <p type="text" class="form-control-plaintext"  value="name" name="empName" id="empNameUp"></p>
                                <span class="invalid-feedback"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="emailUp" class="col-sm-2 col-form-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="emailUp">
                                <span class="invalid-feedback"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">性别</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" checked="checked" name="gender" id="gender1Up" value="1">
                                <label class="form-check-label" for="gender1Up">男</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender2Up" value="2">
                                <label class="form-check-label" for="gender2Up">女</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">部门</label>
                            <div class="col-sm-4">
                                <select class="custom-select" name="dId" id="dIdUp"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveUp">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%-- 员工添加模态框 --%>
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">员工添加</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- 表单 --%>
                    <form id="emp_form">
                        <div class="form-group row">
                            <label for="empName" class="col-sm-2 col-form-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName">
                                <span class="invalid-feedback"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="email" class="col-sm-2 col-form-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="email">
                                <span class="invalid-feedback"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 col-form-label">性别</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" checked="checked" name="gender" id="gender1" value="1">
                                <label class="form-check-label" for="gender1">男</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender2" value="2">
                                <label class="form-check-label" for="gender2">女</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">部门</label>
                            <div class="col-sm-4">
                                <select class="custom-select" name="dId" id="dId"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="save">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%-- 标题 --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%-- 按钮 --%>
    <div class="row">
        <div class="col-md-6 offset-md-8">
            <button class="btn btn-primary" id="addEmp">新增</button>
            <button class="btn btn-danger" id="delete_all_btn">删除</button>
        </div>
    </div>
    <hr>
    <%-- 表格数据 --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped  table-bordered table-hover">
                <thead class="thead-dark">
                <tr>
                    <th>
                        <input type="checkbox" id="check_all" />
                    </th>
                    <th>ID</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <%-- 表数据 --%>
                <tbody id="tableBody"></tbody>
            </table>
        </div>
    </div>
    <hr>
    <%-- 分页页码信息 --%>
    <div class="row">
        <%-- 页数据信息显示 --%>
        <div id="pnInfo" class="col-md-6"></div>
        <%-- 页码显示 --%>
        <div class="col-md-6">
            <nav aria-label="Page navigation example">
                <ul id="pn" class="pagination"></ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>