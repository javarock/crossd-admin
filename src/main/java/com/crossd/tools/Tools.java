package com.crossd.tools;

/**
 * Created by wise.wu on 15-8-28.
 */

import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Tools {

    private static DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    private static DateFormat formatTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 将格式为yyyy-MM-dd的时间字符串装换为Date
     *
     * @param dateString
     * @return
     */
    public static Date getDate(String dateString) {

        if ("".equals(dateString)) {
            return null;
        }

        try {
            return format.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 将格式为yyyy-MM-dd HH:mm:ss的时间字符串装换为Date
     *
     * @param dateString
     * @return
     */
    public static Date getDateTime(String dateString) {

        if ("".equals(dateString) || dateString == null) {
            return null;
        }

        try {
            return formatTime.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Object checkObject(Object arg) throws Exception {
        if (arg instanceof String) {
            return (Object)checkString((String) arg);
        } else if (arg instanceof Integer) {
            return (Object)checkInteger((Integer) arg);
        } else if (arg instanceof Double) {
            return (Object)checkDouble((Double) arg);
        } else {
            throw new Exception("不支持的转换类型!");
        }
    }

    /**
     * 对前台传来的字符串进行校验，若null和"null"返回""
     *
     * @param arg
     * @return arg or ""
     */
    public static String checkString(String arg) {
        if (arg == null || "null".equals(arg)) {
            return "";
        } else {
            return arg;
        }
    }

    /**
     * 对前台传来的Integer进行校验，若null返回0
     *
     * @param arg
     * @return arg or 0
     */
    public static Integer checkInteger(Integer arg) {
        if (arg == null) {
            return 0;
        } else {
            return arg;
        }
    }

    /**
     * 对前台传来的Double进行校验，若null返回0.0D
     *
     * @param arg
     * @return arg or 0.0D
     */
    public static Double checkDouble(Double arg) {
        if (arg == null) {
            return 0.0D;
        } else {
            return arg;
        }
    }

    /**
     * 对前台传来的stock进行校验，若""或"无限"返回-1
     *
     * @param arg
     * @return arg or -1
     */
    public static Integer checkStock(String arg) {
        if ("".equals(arg) || "无限".equals(arg)) {
            return -1;
        } else {
            return Integer.parseInt(arg);
        }
    }

    /**
     *
     * 将inputStream流转成文件，同时关闭inputStream!!
     *
     * @param ins
     * @param file
     * @throws IOException
     */
    public static void inputstreamToFile(InputStream ins, File file) throws IOException {
        OutputStream os = new FileOutputStream(file);
        int bytesRead = 0;
        byte[] buffer = new byte[8192];
        while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
            os.write(buffer, 0, bytesRead);
        }
        os.close();
        ins.close();
    }


    /**
     * 将前台传来的参数存入Map中
     *
     * @param args
     * @return Map<String, Object>
     * @throws Exception
     */
    public static  Map<String, Object> buildParamMap(String[] arg0, Object... arg1) throws Exception {
        Map<String, Object> param = new HashMap<String, Object>();
        for (int i = 0; i < arg1.length; i++) {
            ifNotNullPut(param, arg0[i], arg1[i]);
        }
        return param;
    }

    public static void ifNotNullPut(Map<String, Object> param, String name, Object arg) throws Exception {
        if (arg != null) {
            param.put(name, arg);
        }
    }
}
