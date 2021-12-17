package com.example.spidercommunity.funs;
import org.springframework.web.bind.annotation.RestController;

@RestController  //说明这是一个受spring容器管理的控制器组件(Bean)
public class TestAPI {
    public String test(){
        return "== SpringBoot 测试成功！==";
    }
}
