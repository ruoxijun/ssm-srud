package ruoxijun.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Msg {
    private int code;
    private String msg;
    private Map<String,Object> data = new HashMap<>();

    public Msg(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public static Msg success(){
        Msg msg = new Msg(100,"响应成功");
        return msg;
    }

    public static Msg fail(){
        Msg msg = new Msg(200,"请求失败");
        return msg;
    }

    public Msg addData(String key,Object value){
        this.data.put(key,value);
        return this;
    }
}
