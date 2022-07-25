<%@ page import="com.laptrinhjavaweb.constant.SystemConstant" %>
<%@ page import="com.laptrinhjavaweb.security.utils.SecurityUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formAjax" value="/api/customer"/>
<c:url var="customerListURL" value="/admin/customer"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Quản lý Khách Hàng</title>
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
                        <a href="<c:url value="/admin/home"/>">Trang chủ</a>
                    </li>
                    <li class="active">Danh sách khách hàng</li>
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
                            <form:form commandName="modelSearch" action="${customerListURL}" id="listForm" method="get">
                                <div class="row" >
                                    <div class="col-xs-12">
                                        <div class="col-sm-3">
                                            <label for="name" style="font-weight:bold;">Tên Khách Hàng</label>
                                            <input type="text" id="name" class="form-control" name="name" value="${modelSearch.name}" />
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="name" style="font-weight:bold;">Số Điện Thoại Khách Hàng</label>
                                            <input type="text" id="phone" class="form-control" name="phone" value="${modelSearch.phone}" />
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="col-sm-3">
                                            <label for="name" style="font-weight:bold;">Email Khách Hàng</label>
                                            <input type="text" id="email" class="form-control" name="email" value="${modelSearch.email}" />
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="name" style="font-weight:bold;">Tên công ty</label>
                                            <input type="text" id="companyName" class="form-control" name="companyName" value="${modelSearch.companyName}" />
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="col-sm-3">
                                            <label for="name" style="font-weight:bold;">Yêu cầu</label>
                                            <input type="text" id="demand" class="form-control" name="demand" value="${modelSearch.demand}" />
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="name" style="font-weight:bold;">Tên ghi chú</label>
                                            <input type="text" id="note" class="form-control" name="note" value="${modelSearch.note}" />
                                        </div>
                                    </div>
                                </div><br>
                                <button type="button" class="btn btn-sm btn-success" id="btnSearch">
                                    Tìm Kiếm
                                    <i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
                                </button>
                            </form:form>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="pull-right">
                        <c:if test="<%=SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)%>">
                            <button class="btn btn-white btn-info btn-bold" data-toggle="tooltip" title="Thêm khách hàng">
                                <a href='<c:url value='/admin/customer-insert'/>'>
                                    <i class="fa fa-plus-circle"> </i>
                                </a>
                            </button>
                            <button class="btn btn-white btn-info btn-bold" data-toggle="tooltip" id="btnDeleteCustomer" title="Xóa khách hàng">
                                <a href='<c:url value='/admin/customer-delete'/>'>
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                </a>
                            </button>
                        </c:if>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12"><br/>
                        <table id="customerList" class="table table-striped table-bordered table-hover">
                            <thead >
                            <tr>
                                <th class="center">
                                    <label class="pos-rel">
                                        <input type="checkbox" class="ace" value=""/>
                                        <span class="lbl"></span>
                                    </label>
                                </th>
                                <th >Tên Khách Hàng</th>
                                <th >Số Điện Thoại Khách Hàng</th>
                                <th >Email Khách Hàng</th>
                                <th >Tên Công Ty</th>
                                <th >Yêu Cầu</th>
                                <th >Ghi chú</th>
                                <th >Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${model}">
                                    <tr>
                                        <td class="center">
                                            <label class="pos-rel">
                                                <input type="checkbox" class="ace" value="${item.id}"  >
                                                <span class="lbl"></span>
                                            </label>
                                        </td>
                                        <td>${item.name}</td>
                                        <td>${item.phone}</td>
                                        <td>${item.email}</td>
                                        <td>${item.companyName}</td>
                                        <td>${item.demand}</td>
                                        <td>${item.note}</td>
                                        <td>
                                            <c:if test="<%=SecurityUtils.getAuthorities().contains(SystemConstant.ADMIN_ROLE)%>">
                                                <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Giao khách hàng" onclick="assignmentCustomer(${item.id})">
                                                    <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                </button>
                                            </c:if>
                                            <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Chỉnh Sửa Khách Hàng">
                                                <a href='<c:url value='/admin/customer-updates?id=${item.id}'/>'>
                                                    <i class="ace-icon fa fa-edit"></i>
                                                </a>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div id="assignmentCustomerModel" class="modal fade" role="dialog">
                        <div class="modal-dialog">
                            <!-- Assignment Customer Model-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Danh sách Nhân Viên</h4>
                                </div>
                                <div class="modal-body">
                                    <table class="table table-bordered" id="customersList">
                                        <thead>
                                        <tr>
                                            <th></th>
                                            <th>Tên Nhân Viên</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                    <input type="hidden" id="customerId" name="customerId" value="${mo}" >
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" id = "btnAssignmentCustomer">Giao Khách Hàng</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assets/js/jquery.2.1.1.min.js"></script>
<script>
    function assignmentCustomer(customerId) {
        OpenModelAssignmentCustomer(customerId);
        loadStaff(customerId);
        console.log($('#customerId').val());
    }

    function OpenModelAssignmentCustomer(customerId){
        $('#assignmentCustomerModel').modal();
        $('#btnAssignmentCustomer').click(function (e) {
            e.preventDefault();
            var data = {};
            data['customerId'] = customerId;
            var staffs  = $('#customersList').find('tbody input[type=checkbox]:checked').map( function () {
                return $(this).val();
            }).get();
            data['staffs '] = staffs ;
            assignCustomer(staffs,customerId);
        });
    }
    function assignCustomer(staffs,customerId){
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/api/customer/"+customerId+"/assignment",
            data: JSON.stringify(staffs),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                window.location.href = "<c:url value='/admin/customer'/>";
                console.log('success');
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
            }

        });
    }
    function loadStaff(customerId) {
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/api/customer/"+customerId+"/staffs",
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

                $('#customersList tbody').html(row);
                console.log('success');
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
            }

        });
    }
    $('#btnDeleteCustomer').click(function (e) {
        e.preventDefault();
        var ids = $('#customerList').find('tbody tr td label input[type=checkbox]:checked').map( function () {
            return $(this).val();
        }).get();
        deleteCustomer(ids);

    });
    function deleteCustomer(data){
        $.ajax({
            url: '${formAjax}/',
            type: 'DELETE',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                window.location.href = "<c:url value='/admin/customer'/>";
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
    <script type="text/javascript">
        var active_class = 'active';
        $('#customerList > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
            var th_checked = this.checked;//checkbox inside "TH" table header

            $(this).closest('table').find('tbody > tr').each(function(){
                var row = this;
                if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });

        //select/deselect a row when the checkbox is checked/unchecked
        $('#customerList').on('click', 'td input[type=checkbox]' , function(){
            var $row = $(this).closest('tr');
            if(this.checked) $row.addClass(active_class);
            else $row.removeClass(active_class);
        });
    </script>
</body>
</html>
