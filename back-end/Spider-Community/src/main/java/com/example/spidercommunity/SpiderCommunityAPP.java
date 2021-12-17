package com.example.spidercommunity;

import com.example.spidercommunity.funs.TestAPI;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
@MapperScan({"com.example.spidercommunity.*.*.*.dao"})
@MapperScan({"com.example.spidercommunity.*.*.*.*.dao"})
public class SpiderCommunityAPP {

    public static void main(String[] args) {
        // ApplicationContext : spring容器对象
        ApplicationContext context = SpringApplication.run(SpiderCommunityAPP.class, args);

        // 从容器中获取指定类型的对象（前提：容器中有此类型的对象）
        TestAPI testAPI = context.getBean(TestAPI.class);
        System.out.println(testAPI.test());

    }

}
