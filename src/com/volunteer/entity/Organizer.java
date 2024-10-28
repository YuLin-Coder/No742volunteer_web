package com.volunteer.entity;

/**
 * @author hxh
 * @version V1.00
 * @date 2022/1/10 9:32
 * @since V1.00
 */
public class Organizer {
    private Integer id;
    private String  realname;
    private String  phone;
    private String  pwd;
    private String  type;
    private String  tx;
    private String  status;
    private String  registe_time;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTx() {
        return tx;
    }

    public void setTx(String tx) {
        this.tx = tx;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRegiste_time() {
        return registe_time;
    }

    public void setRegiste_time(String registe_time) {
        this.registe_time = registe_time;
    }
}
