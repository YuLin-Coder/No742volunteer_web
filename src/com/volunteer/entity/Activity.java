package com.volunteer.entity;

/**
 * @author hxh
 * @version V1.00
 * @date 2022/1/10 13:58
 * @since V1.00
 */
public class Activity {
    private Integer id;
    private String  title;
    private String  cname;
    private String   img;
    private String  detail;
    private String  note;
    private String  fbrq;
    private String  start_time;
    private String  end_time;
    private String  status1;
    private String  status2;
    private Integer  total;
    private Integer  yzmcount;
    private Integer  oid;
    private String  oname;

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

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getFbrq() {
        return fbrq;
    }

    public void setFbrq(String fbrq) {
        this.fbrq = fbrq;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getStatus1() {
        return status1;
    }

    public void setStatus1(String status1) {
        this.status1 = status1;
    }

    public String getStatus2() {
        return status2;
    }

    public void setStatus2(String status2) {
        this.status2 = status2;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getYzmcount() {
        return yzmcount;
    }

    public void setYzmcount(Integer yzmcount) {
        this.yzmcount = yzmcount;
    }

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public String getOname() {
        return oname;
    }

    public void setOname(String oname) {
        this.oname = oname;
    }
}
