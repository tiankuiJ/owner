<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/8
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<style>
    .pm_tabel {
        border: 1px solid #dddddd;
        width: auto;
        min-height: 35px;
        margin-bottom: 10px;
    }

    .pm_tabel tr {
        width: 100%;
        border-bottom: 1px solid #dddddd;
        height: 35px;
    }

    .pm_tabel td {
        width: 12.33%;
        text-align: center;
        padding: 3px 0;
        height: 35px;
        border-right: 1px solid #dddddd;
    }

    .pm_tabelColr {
        color: #4876FF;
        font-size: 18px;
        font-weight: 700;
    }
</style>
<head>
    <title>Title</title>
</head>
<body>
<div class="row">
    <div class="">
        <table class="pm_tabel">
            <tr>
                <td>名次</td>
                <td>名称</td>
                <td>同意票数</td>
                <td>反对票数</td>
                <td>弃权票数</td>
                <td>同意业主总面积</td>
                <td>同意业主面积占比</td>
                <%--<td>弃权业主总面积</td>--%>
            </tr>
            <c:forEach items="${optionList}" var="optionItem" varStatus="st">
                <tr>
                    <td
                            <c:if test="${st.index<3}">
                                class="pm_tabelColr"
                            </c:if>

                    >${st.index+1}
                    </td>
                    <td>${optionItem.name}</td>
                    <td>${optionItem.countAgreen}</td>
                    <td>${optionItem.countReject}</td>
                    <td>${optionItem.countGiveUp}</td>
                    <td>${optionItem.sumAgreen}</td>
                    <td>  <fmt:formatNumber type="number" value="${(optionItem.sumAgreen/joinSumAcreage)*100 }" pattern="0.00" maxFractionDigits="2"/>%  </td>
                    <%--<td>${optionItem.sumGiveUp}</td>--%>

                </tr>
            </c:forEach>
        </table>

        <div class="form-group">
            <button id="btn" type="button"
                        onclick="loadPage('/regRecord/voteRecordListUI.action','投票参加记录')"
                    class="btn btn-info btn-sm">
                <i class="fa fa-undo"></i>&nbsp;返回
            </button>
        </div>
    </div>
</div>
</body>
</html>
