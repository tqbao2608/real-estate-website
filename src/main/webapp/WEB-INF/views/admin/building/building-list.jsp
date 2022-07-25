<%@ page import="com.laptrinhjavaweb.security.utils.SecurityUtils" %>
<%@ page import="com.laptrinhjavaweb.constant.SystemConstant" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="buildingListURL" value="/admin/building-list"/>
<c:url var="formAjax" value="/api/building"/>
<c:url var="buildingInsertURL" value="/admin/building-insert" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Danh Sách Tòa Nhà</title>
</head>
<body>
    <div class="main-content">

        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
                </script>
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="<c:url value="/admin/home"/>">
                            <%--<spring:message code="label.home"/>--%>
                            Trang chủ
                        </a>
                    </li>
                    <li class="active">Danh sách tòa nhà</li>
                </ul><!-- /.breadcrumb -->
            </div>
            <div class="page-content">
                <div class="widget-box">
                    <div class="widget-header">
                        <h4 class="widget-title">Tìm Kiếm</h4>
                        <div class="widget-toolbar">
                            <a href="#" data-action="collapse">
                                <i class="ace-icon fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <c:if test="${not empty messageResponse}">
                        <div class="alert alert-${alert}">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="ace-icon fa fa-times"></i>
                            </button>
                                ${messageResponse}
                        </div>
                   </c:if>
                    <div class="widget-body">
                        <div class="widget-main">
                            <form:form commandName="modelSearch" action="${buildingListURL}" id="listForm" method="get">
                                 <div class="row" >
                                     <div class="col-xs-12">
                                         <div class="col-sm-6">
                                            <label for="name" style="font-weight:bold;">Tên Toàn Nhà</label>
                                            <input type="text" id="name" class="form-control" name="name" value="${modelSearch.name}" />
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="floorArea" style="font-weight:bold;">Diện Tích Sàn</label>
                                            <input type="number" id="floorArea" class="form-control" name="floorArea" value="${modelSearch.floorArea}"/>
                                        </div>
                                    </div>
                                     <div class="col-xs-12"><br/>
                                         <div class="col-xs-2">
                                             <div>
                                                 <label for="form-field-select-3" style="font-weight:bold;">Chọn Quận</label><br />
                                                 <select class="form-control" id="form-field-select-3" name="district">
                                                     <c:if test="${not empty modelSearch.district}">
                                                         <c:forEach var="item" items="${district}">
                                                             <option value="${item.key}" ${item.key == modelSearch.district ? 'selected' : ''}>
                                                                     ${item.value}</option>
                                                         </c:forEach>
                                                         <option value="">-- Chọn Quận --</option>
                                                     </c:if>
                                                     <c:if test="${empty modelSearch.district}">
                                                         <option value="">-- Chọn Quận --</option>
                                                         <c:forEach var="item" items="${district}">
                                                             <option value="${item.key}" >${item.value}</option>
                                                         </c:forEach>
                                                     </c:if>
                                                </select>
                                            </div>
                                        </div>
                                         <div class="col-sm-5">
                                             <div>
                                                 <label for="ward" style="font-weight:bold;">Phường</label>
                                                <input type="text" id="ward" class="form-control" name="ward" value="${modelSearch.ward}" />
                                            </div>
                                        </div>
                                         <div class="col-sm-5">
                                             <div>
                                                 <label for="street" style="font-weight:bold;">Đường</label>
                                                <input type="text" id="street" class="form-control" name="street" value="${modelSearch.street}" />
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-xs-12"><br/>
                                         <div class="col-sm-4">
                                             <div>
                                                <label for="numberOfBasement" style="font-weight:bold;">Số Tầng Hầm</label>
                                                <input type="number" id="numberOfBasement" class="form-control" name="numberOfBasement" value="${modelSearch.numberOfBasement}" />
                                            </div>
                                        </div>
                                         <div class="col-sm-4">
                                             <div>
                                                 <label for="direction" style="font-weight:bold;">Hướng</label>
                                                 <input type="text" id="direction" class="form-control" name="direction" value="${modelSearch.direction}" />
                                            </div>
                                        </div>
                                         <div class="col-sm-4">
                                             <div>
                                                <label for="level" style="font-weight:bold;">Hạng</label>
                                                <input type="text" id="level" class="form-control" name="level" value="${modelSearch.level}"/>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-xs-12"><br/>
                                         <div class="col-sm-3"><div>
                                                <label for="areaFrom" style="font-weight:bold;">Diện Tích Từ</label>
                                                <input type="number" id="areaFrom" class="form-control" name="areaFrom" value="${modelSearch.areaFrom}" />
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div>
                                                <label for="areaTo" style="font-weight:bold;">Diện Tích Đến</label>
                                                <input type="number" id="areaTo" class="form-control" name="areaTo" value="${modelSearch.areaTo}" />
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div>
                                                <label for="rentPriceFrom" style="font-weight:bold;">Giá Thuê Từ</label>
                                                <input type="number" id="rentPriceFrom" class="form-control" name="rentPriceFrom" value="${modelSearch.rentPriceFrom}"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div>
                                                <label for="rentPriceTo" style="font-weight:bold;">Giá Thuê Đến</label>
                                                <input type="number" id="rentPriceTo" class="form-control" name="rentPriceTo"  value="${modelSearch.rentPriceTo}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12"><br/>
                                        <div class="col-sm-4">
                                            <div>
                                                <label for="managerName" style="font-weight:bold;">Tên Quản Lý</label>
                                                    <%--                                            <form:input path="managerName" cssClass="form-control" />--%>
                                                <input type="text" id="managerName" class="form-control" name="managerName" value="${modelSearch.managerName}" />
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div>
                                                <label for="managerPhone" style="font-weight:bold;">Điện Thoại Quản Lý</label>
                                                    <%--                                            <form:input path="managerPhone" cssClass="form-control" />--%>
                                                <input type="text" id="managerPhone" class="form-control" name="managerPhone" value="${modelSearch.managerPhone}"/>
                                            </div>
                                        </div>
                                        <c:if test="<%=SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)%>">
                                            <div class="col-sm-2">
                                                <label style="font-weight:bold;"> Chọn Nhân Viên Quản Lý</label>
                                                <select class="form-control" name="staffId" >
                                                    <c:if test="${not empty modelSearch.staffId}">
                                                        <c:forEach var="item" items="${staffmaps}">
                                                            <option value="${item.key}" ${item.key == modelSearch.staffId ? 'selected' : ''}>
                                                                    ${item.value}</option>
                                                        </c:forEach>
                                                        <option value="">-- Chọn nhân viên --</option>
                                                    </c:if>
                                                    <c:if test="${empty modelSearch.staffId}">
                                                        <option value="">-- Chọn nhân viên --</option>
                                                        <c:forEach var="item" items="${staffmaps}">
                                                            <option  value="${item.key}">${item.value}</option>
                                                        </c:forEach>
                                                    </c:if>
                                                </select>
                                            </div>
                                        </c:if>
                                    </div>
                                </div><br>
                                <div class="checkbox">
                                    <c:if test="${not empty modelSearch.typesList}">
                                        <c:forEach var="item" items="${typebuilding}">
                                            <label>
                                                <input  type="checkbox"  class="ace" value="${item.key}" name = "types"
                                                    ${modelSearch.typesList.contains(item.key) ? "checked" :''}/>
                                                <span class="lbl" style="font-weight:bold;">${item.value}</span>
                                            </label>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty modelSearch.typesList}">
                                        <c:forEach var="item" items="${typebuilding}">
                                            <label>
                                                <input  type="checkbox" class="ace" value="${item.key}" name = "typesList"/>
                                                <span class="lbl" style="font-weight:bold;">${item.value}</span>
                                            </label>
                                        </c:forEach>
                                    </c:if>
                                </div><br>
                                <button type="button" class="btn btn-sm btn-success" id="btnSearch">
                                    Tìm Kiếm
                                    <i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
                                </button>
                        </div>
                        </form:form>
                    </div>
                </div>
                <div>
                    <div class="pull-right">
                        <c:if test="<%=SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)%>">
                            <button class="btn btn-white btn-info btn-bold" data-toggle="tooltip" title="Thêm tòa nhà">
                                <a href='<c:url value='/admin/building-insert'/>'>
                                    <i class="fa fa-plus-circle"> </i>
                                </a>
                            </button>
                            <button class="btn btn-white btn-info btn-bold" data-toggle="tooltip" id="btnDeleteBuilding" title="Xóa Tòa Nhà">
                                <a href='<c:url value='/admin/building-delete'/>'>
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                </a>
                            </button>
                        </c:if>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12"><br/>
                        <table id="buildingList" class="table table-striped table-bordered table-hover">
                            <thead >
                            <tr>
                                <th class="center">
                                    <label class="pos-rel">
                                        <input type="checkbox" class="ace" />
                                        <span class="lbl"></span>
                                    </label>
                                </th>
                                <th >Tên Sản Phẩm</th>
                                <th>Địa Chỉ</th>
                                <th>Số Tầng Hầm</th>
                                <th>Diện Tích Sàn</th>
                                <th>Giá Thuê</th>
                                <th>Mô Tả</th>
                                <th>Diện Tích Thuê</th>
                                <th>Thao Tác</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${model}">
                                    <tr class="">
                                        <td class="center">
                                            <label class="pos-rel">
                                                <input type="checkbox" class="ace" value="${item.id}"  >
                                                <span class="lbl"></span>
                                            </label>
                                        </td>
                                        <td>${item.name}</td>
                                        <td>${item.address}</td>
                                        <td>${item.numberOfBasement}</td>
                                        <td>${item.floorArea}</td>
                                        <td>${item.rentPrice}</td>
                                        <td>${item.rentPriceDescription}</td>
                                        <td>${item.rentArea}</td>
                                        <td>
                                            <c:if test="<%=SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)%>">
                                                <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Giao Tòa Nhà" onclick="assingmentBuilding(${item.id})">
                                                    <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                </button>
                                            </c:if>
                                            <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Chỉnh Sửa Tòa Nhà">
                                                <a href='<c:url value='/admin/building-update?id=${item.id}'/>'>
                                                    <i class="ace-icon fa fa-edit"></i>
                                                </a>

                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <ul class="pagination" id="pagination"></ul>
                        <input type="hidden" value="" id="page" name="page" />
                        <input type="hidden" value="" id="maxPageItem" name="maxPageItem" />
                        <input type="hidden" value="" id="sortName" name="sortName" />
                        <input type="hidden" value="" id="sortBy" name="sortBy" />
                    </div>
                </div>
            </div>
        </div>
    </div><!-- /.main-content -->
    <!--Giao Tòa nhà -->
    <div id="assingmentBuildingModel" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Assignment Building Model-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Danh sách nhân viên</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered" id="staffList">
                        <thead>
                        <tr>
                            <th></th>
                            <th>Tên Nhân Viên</th>
                        </tr>
                        </thead>

                        <tbody>

                        </tbody>
                    </table>

                    <input type="hidden" id="buildingId" name="buildingId" value="" >
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id = "btnAssignmentBuilding">Giao Tòa Nhà</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div><!-- /.main-container -->
    <script src="assets/js/jquery.2.1.1.min.js"></script>
    <script>
        var currentPage = 1;
        var totalPages = 10;
        var limit = 2;
        $(function() {
            window.pagObj = $('#pagination').twbsPagination({
                totalPages : totalPages,
                visiblePages : 10,
                startPage : currentPage,
                onPageClick : function(event, page) {
                    if (currentPage != page) {
                        $('#maxPageItem').val(limit);
                        $('#page').val(page);
                        $('#sortName').val('id');
                        $('#sortBy').val('asc');
                        $('#formSubmit').submit();
                    }
                }
            })
        });
    </script>
<script>

    function assingmentBuilding(buildingId){
        OpenModelAssnigmentBuilding(buildingId);
        loadStaff(buildingId);

        console.log($('#buildingId').val());
    }
    function loadStaff(buildingId) {
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/api/building/"+buildingId+"/staffs",
            //data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                var row = '';
                $.each(response, function (index,item){
                   row += '<tr>';
                   row += '<td  class="text-center"> <input type="checkbox" ' +
                       'value='+item.id+' id = "checkbox_'+item.id +'" class = "check-box-element "' + item.checked + '/></td>';
                   row += '<td  class="text-center">' +item.fullName+'</td>';
                   row += '</tr>';
                   });

                $('#staffList tbody').html(row);
                console.log('success');
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
            }

        });
    }
    function OpenModelAssnigmentBuilding(buildingId){
        $('#assingmentBuildingModel').modal();
        $('#btnAssignmentBuilding').click(function (e) {
            e.preventDefault();
            var data = {};
            data['buildingId'] = buildingId;
            var staffs = $('#staffList').find('tbody input[type=checkbox]:checked').map( function () {
                return $(this).val();
            }).get();
            data['staffs'] = staffs;
            assingStaff(staffs,buildingId);
        });
    }
    $('#btnUpdateBuilding').click(function (e) {
        e.preventDefault();
        var data = {};
        data['buildingId'] = $('#buildingId').val();
        updateBuilding(data);
    });

    $('#btnDeleteBuilding').click(function (e) {
        e.preventDefault();
        var buildingIds = $('#buildingList').find('tbody tr td label input[type=checkbox]:checked').map( function () {
            return $(this).val();
        }).get();
        deleteBuilding(buildingIds);

    });

    function updateBuilding(data){
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/api/building",
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                console.log('success');
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
            }

        });
    }

    function assingStaff(staffs,buildingId){
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/api/building/"+buildingId+"/assignment",
            data: JSON.stringify(staffs),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                window.location.href = "<c:url value='/admin/building-list'/>";
                console.log('success');
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
            }

        });
    }
    function deleteBuilding(data){
        $.ajax({
            url: '${formAjax}/',
            type: 'DELETE',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                window.location.href = "<c:url value='/admin/building-list?message=delete_success'/>";
                console.log('success');
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
            }

        });
    }

    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    });
</script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
    var active_class = 'active';
    $('#buildingList > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
        var th_checked = this.checked;//checkbox inside "TH" table header

        $(this).closest('table').find('tbody > tr').each(function(){
            var row = this;
            if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
            else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
        });
    });

    //select/deselect a row when the checkbox is checked/unchecked
    $('#buildingList').on('click', 'td input[type=checkbox]' , function(){
        var $row = $(this).closest('tr');
        if(this.checked) $row.addClass(active_class);
        else $row.removeClass(active_class);
    });
</script>
</body>
</html>
