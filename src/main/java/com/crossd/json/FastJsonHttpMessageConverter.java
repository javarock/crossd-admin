//package com.crossd.json;
//
//import com.alibaba.fastjson.JSON;
//import org.apache.commons.io.IOUtils;
//import org.springframework.http.HttpInputMessage;
//import org.springframework.http.HttpOutputMessage;
//import org.springframework.http.MediaType;
//import org.springframework.http.converter.AbstractHttpMessageConverter;
//import org.springframework.http.converter.HttpMessageNotReadableException;
//import org.springframework.http.converter.HttpMessageNotWritableException;
//
//import java.io.IOException;
//import java.io.OutputStream;
//import java.nio.charset.Charset;
//
///**
// * 自定义的 HttpMessageConverter，用于将 Controller 中 @ResponseBody 方法的返回值转换为 JSON 字符串。
// *
// * 之所以不用 Jackson，是因为实际运行当中可能出现一些非常特殊的字符导致浏览器无法解析 JSON。
// *
// * 解决办法是对生成的 JSON 再做一次转义，将非 ascii 字符转换为 '\u0000' 的形式，避免特殊字符的出现。
// *
// * 另外之所以不用 Gson，是因为 Gson 拒绝对内部类做转换，而 JsonResult 在 SpringMVC 中被转换成了一个内部类对象。
// *
// * @author yiding.he
// */
//public class FastJsonHttpMessageConverter extends AbstractHttpMessageConverter<Object> {
//
//    public static final Charset DEFAULT_CHARSET = Charset.forName("UTF-8");
//
//    public FastJsonHttpMessageConverter() {
//        super(new MediaType("application", "json", DEFAULT_CHARSET));
//    }
//
//    @Override
//    public boolean canRead(Class<?> clazz, MediaType mediaType) {
//        return true;
//    }
//
//    @Override
//    public boolean canWrite(Class<?> clazz, MediaType mediaType) {
//        return true;
//    }
//
//    @Override
//    protected boolean supports(Class<?> clazz) {
//        throw new UnsupportedOperationException();
//    }
//
//    @Override
//    protected Object readInternal(Class<?> clazz, HttpInputMessage inputMessage) throws IOException, HttpMessageNotReadableException {
//        return JSON.parseObject(IOUtils.toByteArray(inputMessage.getBody()), clazz);
//    }
//
//    @Override
//    protected void writeInternal(Object o, HttpOutputMessage outputMessage) throws IOException, HttpMessageNotWritableException {
//        String jsonString = parse(o);
//
//        OutputStream out = outputMessage.getBody();
//        out.write(jsonString.getBytes(DEFAULT_CHARSET));
//        out.flush();
//    }
//
//    public static String parse(Object o) {
//        String jsonString = JSON.toJSONString(o);
//
//        jsonString = addEscapes(jsonString);    // 将非 ascii 字符转义为 \u0000 形式
//        return jsonString;
//    }
//
//    protected static String addEscapes(String str) {
//        StringBuilder retval = new StringBuilder();
//        char ch;
//        for (int i = 0; i < str.length(); i++) {
//            if ((ch = str.charAt(i)) < 0x20 || ch > 0x7e) {
//                String s = "0000" + Integer.toString(ch, 16);
//                retval.append("\\u").append(s.substring(s.length() - 4, s.length()));
//            } else {
//                retval.append(ch);
//            }
//        }
//        return retval.toString();
//    }
//}
