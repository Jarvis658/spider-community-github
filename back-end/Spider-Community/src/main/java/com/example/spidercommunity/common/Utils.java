package com.example.spidercommunity.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {

    // 将一个Java对象转换为json串，并向浏览器（客户端）输出
    public static void outJson(HttpServletResponse resp, Object obj) throws IOException {
        // json的媒体标准：application/json  设置字符编码
        resp.setContentType("application/json;charset=UTF-8");

        // 获取向客户端发送字符信息流对象
        PrintWriter out = resp.getWriter();

        // 将Java对象转化为json格式字符串
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonString = objectMapper.writeValueAsString(obj);
        out.print(jsonString);

        out.flush();
        out.close();
    }

    /**
     * regex：获取<img src="">标签的正则（"<img.*?>"）
     * string：提取图片标签的内容
     * isDistinguish：是否区分大小写
     */
//    public static List<String> getMatchString(String regex, String string, boolean isDistinguish){
    public static List<String> getMatchString(String content){
        List<String> pics = new ArrayList<>();// 因文件可能有多张图片，故用集合来存储结果
        Pattern compile = null;
//        if (isDistinguish){
        compile = Pattern.compile("<img.*?>");//默认大小写敏感，得到一个模式
//        }else{
//            compile = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
//        }
        Matcher matcher = compile.matcher(content);//将得到的模式创建Matcher对象，对content进行正则表达式匹配
        while (matcher.find()){
            String img = matcher.group();
//            pics.add(img); // 这一步得到的都是”<img src=”...“>“，下面将图片url从src中解析出来
            /**
             * reg_html_img_src_http: 获取src中 "" 图片地址的正则("\"http?(.*?)(\"|>|\\s+)")
             *
             * 获取标签中src的正则表达式（"src\\s*=\\s*\"?(.*?)(\"|>|\\s+)"）
             */
            Matcher m = Pattern.compile("\"http?(.*?)(\"|>|\\s+)").matcher(img);
            m.find();
            String group = m.group();
            pics.add(group.substring(1, group.length() - 1));
        }
        return pics;
    }
}
