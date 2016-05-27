package com.crossd.tools;

/**
 * Created by wise.wu on 15-8-28.
 */

import org.apache.commons.lang.StringUtils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;

public class AESUtil {
    public static void main(String[] args){
//        String str = "fdf";
//        String password = "@#$/45s";
//        String passwordStr = AESUtil.encrypt(str, password);
//        System.out.println(passwordStr);
//        String result = AESUtil.decrypt(passwordStr, password);
//        System.out.println(result);
//        if(result.equals(str)){
//            System.out.println("success");
//        }
        String password = "123456";
        String passwordStr = AESUtil.encrypt(password,"sfCnE2ojf@#$/45s&s234");
        System.out.println(passwordStr);
        String result = AESUtil.decrypt(passwordStr, "sfCnE2ojf@#$/45s&s234");
        System.out.println(result);
    }

    /**
     * 加密字符串
     * @param content
     * @param password
     * @return
     */
    public static String encryptToString(String content, String password){
        if(StringUtils.isBlank(content)){
            return "";
        }
        if(StringUtils.isBlank(password)){
            throw new RuntimeException("加密密码不能为空");
        }
        return encrypt(content,password);
    }

    /**
     * 解密字符串
     * @param content
     * @param password
     * @return
     */
    public static String decryptToString(String content, String password){
        if(StringUtils.isBlank(content)){
            return "";
        }
        if(StringUtils.isBlank(password)){
            throw new RuntimeException("解密密码不能为空");
        }
        return decrypt(content,password);
    }

    /**
     * 加密  password为空则使用默认加密key;
     * @param content
     * @param password
     * @return  加密后字符串
     */
    private static String encrypt(String content, String password) {
        try {
            SecretKey secretKey = getKey(password);
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
            Cipher cipher = Cipher.getInstance("AES");// 创建密码器
            byte[] byteContent = content.getBytes("utf-8");
            cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
            byte[] result = cipher.doFinal(byteContent);
            return parseByte2HexStr(result); // 加密
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 解密
     * @param contentStr
     * @param password
     * @return 解密后字符串
     */
    private static String decrypt(String contentStr, String password) {
        try {
            byte[] content = parseHexStr2Byte(contentStr);
            SecretKey secretKey = getKey(password);
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
            Cipher cipher = Cipher.getInstance("AES");// 创建密码器
            cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
            byte[] result = cipher.doFinal(content);
            return new String(result,"utf-8"); // 加密
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**将二进制转换成16进制
     * @param buf
     * @return
     */
    public static String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**将16进制转换为二进制
     * @param hexStr
     * @return
     */
    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length()/2];
        for (int i = 0;i< hexStr.length()/2; i++) {
            int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);
            int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }


    private static SecretKey getKey(String strKey) {
        try {
            KeyGenerator _generator = KeyGenerator.getInstance( "AES" );
            SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" );
            secureRandom.setSeed(strKey.getBytes());
            _generator.init(128,secureRandom);
            return _generator.generateKey();
        }  catch (Exception e) {
            throw new RuntimeException( " 初始化密钥出现异常 " );
        }
    }
}
