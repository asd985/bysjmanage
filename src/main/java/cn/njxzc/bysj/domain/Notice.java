package cn.njxzc.bysj.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * 公告表
 */
public class Notice implements Serializable {
    private Integer id;
    private String username;
    private String title;
    private String content;
    private Date createTime;

    private String name;//根据username获取

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date crateTime) {
        this.createTime = crateTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", crateTime=" + createTime +
                ", name='" + name + '\'' +
                '}';
    }
}
