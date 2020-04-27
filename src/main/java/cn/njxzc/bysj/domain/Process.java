package cn.njxzc.bysj.domain;

public class Process extends Paper {

    private int taskStatus;
    private int reportStatus;
    private int checkStatus;
    private int paperfirstStatus;
    private int paperendStatus;

    public int getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(int taskStatus) {
        this.taskStatus = taskStatus;
    }

    public int getReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(int reportStatus) {
        this.reportStatus = reportStatus;
    }

    public int getCheckStatus() {
        return checkStatus;
    }

    public void setCheckStatus(int checkStatus) {
        this.checkStatus = checkStatus;
    }

    public int getPaperfirstStatus() {
        return paperfirstStatus;
    }

    public void setPaperfirstStatus(int paperfirstStatus) {
        this.paperfirstStatus = paperfirstStatus;
    }

    public int getPaperendStatus() {
        return paperendStatus;
    }

    public void setPaperendStatus(int paperendStatus) {
        this.paperendStatus = paperendStatus;
    }
}
