package com.volunteer.entity;

/**
 * @author hxh
 * @version V1.00
 * @date 2021/12/30 20:17
 * @since V1.00
 */
public class Category {

    private Integer id;
    private String  cname;
    private String  note;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
