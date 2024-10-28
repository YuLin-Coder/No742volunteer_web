package com.volunteer.entity;

/**
 * @author hxh
 * @version V1.00
 * @date 2022/1/10 11:21
 * @since V1.00
 */
public class Board {

    private Integer id;
    private String  title;
    private String  content;
    private String  img;
    private String  fbsj;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getFbsj() {
        return fbsj;
    }

    public void setFbsj(String fbsj) {
        this.fbsj = fbsj;
    }
}
