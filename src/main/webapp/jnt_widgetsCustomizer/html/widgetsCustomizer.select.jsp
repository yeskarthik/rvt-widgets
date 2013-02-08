<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>

<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>

<jcr:node path="${param['path']}" var="widgets"/>
<template:addCacheDependency flushOnPathMatchingRegexp="\Q${widgets.path}\E/.*"/>

<div class="allWidgets">
    <c:if test="${not empty currentNode.properties.customizePopupText}">
        ${currentNode.properties.customizePopupText.string}
    </c:if>
    <c:if test="${empty currentNode.properties.customizePopupText}">
        <h3><fmt:message key="label.widget.addComponents"/></h3>
    </c:if>
    <c:forEach items="${widgets.nodes}" var="node" varStatus="status">
        <c:if test="${!jcr:isNodeType(node, 'jnt:acl' )}">
            <c:if test="${jcr:isNodeType(node, 'jmix:nodeReference')}">
                <%-- Add dependency to references --%>
                <template:addCacheDependency uuid="${node.properties['j:node'].string}"/>
            </c:if>
            <c:set var="widgetTitle" value="${functions:removeHtmlTags(node.displayableName)}"/>
            <a href="#"
               onclick="addWidget('${node.path}','${node.name}')">${fn:substring(widgetTitle, 0,40)} ${fn:length(widgetTitle) > 40?" ...":""}</a><br/>
        </c:if>
    </c:forEach>
</div>
