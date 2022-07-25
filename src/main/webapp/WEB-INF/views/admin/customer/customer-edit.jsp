<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Edit Khách Hàng</title>
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
                    <a href="#">Home</a>
                </li>
                <li class="active">Edit khách hàng</li>
            </ul><!-- /.breadcrumb -->
        </div><br />
        <div class="row">
            <div class="col-xs-12">
                <c:if test="${not empty messageResponse}">
                    <div class="alert alert-block alert-${alert}">
                        <button type="button" class="close" data-dismiss="alert">
                            <i class="ace-icon fa fa-times"></i>
                        </button>
                            ${messageResponse}
                    </div>
                </c:if>
                <form class="form-horizontal" role="form" id="formEdit" >
                    <label class="col-xs-2" for="name">Tên Khách Hàng</label>
                    <input type="text" class="col-xs-6" id="name" name="name" value="${model.name}"><br><br>

                    <label class="col-xs-2" for="name">Số điện thoại khách hàng</label>
                    <input type="text" class="col-xs-6" id="phone" name="phone" value="${model.phone}"><br><br>

                    <label class="col-xs-2" for="name">Email khách hàng</label>
                    <input type="text" class="col-xs-6" id="email" name="email" value="${model.email}"><br><br>

                    <label class="col-xs-2" for="name">Tên Công Ty</label>
                    <input type="text" class="col-xs-6" id="companyName" name="companyName" value="${model.companyName}"><br><br>

                    <label class="col-xs-2" for="name">Yêu Cầu</label>
                    <input type="text" class="col-xs-6" id="demand" name="demand" value="${model.demand}"><br><br>

                    <label class="col-xs-2" for="name">Ghi Chú</label>
                    <input type="text" class="col-xs-6" id="note" name="note" value="${model.note}"><br><br>
                    <input type="hidden" id="customerId" name="customerId" value="${model.id}" >
                    <button type="button" class="btn btn-primary" id="btnAddOrUpdateCustomer"> Thêm Khách Hàng</button>
                    <button type="button" class="btn btn-primary"> Hủy</button>

                </form>
                <br/><br/>
                <div class="col-xs-12">
                    <c:forEach var="item" items="${modelMap}">
                        <form id="${item.key}">
                            <div class="widget-box" >
                                <div class="widget-header">
                                    <h4 class="widget-title">${modelTransaction.get(item.key)}</h4>
                                    <div class="widget-toolbar">
                                        <a href="#" data-action="collapse">
                                            <i class="ace-icon fa fa-chevron-up"></i>
                                        </a>
                                    </div>
                                    <button class="btn btn-xs btn-info" data-toggle="tooltip" form="${item.key}"
                                            title="Thêm giao dịch"id="btnTransaction_${item.key}"   >
                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                    </button>
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <table class="table table-bordered" id="btnTransaction_${item.key}">
                                            <thead>
                                            <tr>
                                                <th class="col-xs-3">Ngày tạo</th>
                                                <th class="col-xs-3">Ghi chú</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="itemTable" items="${item.value}" varStatus="loop">
                                                <tr>
                                                    <td>${itemTable.createdDate}</td>
                                                    <td>${itemTable.note}</td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <input type="text" class="col-xs-6" id="tblNote" name="tblNote" value="">
                                                    <input type="hidden" id="code" name="code" value="${item.key}">
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.main-content -->
<script src="assets/js/jquery.2.1.1.min.js"></script>
<script>
    /*function insertTransaction(idButton,customerId) {
        $('#btnTransaction').click(function (e) {
            e.preventDefault();
            var data = {};
            var customerId = customerId;
            var note = $(idButton).find('table[id=tblTransaction] tbody tr td input[type=text]').map(function () {
                return $(this).val();
            }).get();
            var code = $(idButton).find(' table[id=tblTransaction] tbody tr td input[type=hidden]').map(function () {
                return $(this).val();
            }).get();
            data['note '] = note;
            data['code '] = code;
            $.ajax({
                type: "POST",
                url: "http://localhost:8080/api/customer/" + {customerId} + "/transaction?note= " + note + "&code=" + code + "",
                data: JSON.stringify(data),
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
        });

    }*/
    $("button").click(function() {
        alert(this.id);

        var idButton = this.id;
        var note = $(idButton).find('tbody tr td input[type=text]').map(function () {
            return $(this).val();
        }).get();
        var code = $(idButton).find('tbody tr td input[type=hidden]').map(function () {
            return $(this).val();
        }).get();

    });
    $('#btnAddOrUpdateCustomer').click(function () {
        var data = {};
        var transaction = [];
        var formData = $('#formEdit').serializeArray();
        $.each(formData, function (index, v) {
            if( v.name == 'transaction'){
                transaction.push(v.value);
            } else{
                data[""+v.name+""] = v.value;
            }
        });
        id = $('#customerId').val();
        var  url = "http://localhost:8080/api/customer";
        var type = "POST";
        if(id.length != 0){
            url += "/" + id ;
            type = "PUT";
        }
        data['id'] = id;
        data['transaction'] = transaction;
        $.ajax({
            type: type,
            url: url,
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                console.log('success');
                if (type === "POST"){
                    window.location.href = "<c:url value='/admin/customer?message=insert_success'/>";
                } else {
                    window.location.href = "<c:url value='/admin/customer?message=update_success'/>";
                }
            },
            error: function (response) {
                console.log('failed');
                console.log(response);
                if (type === "POST"){
                    window.location.href = "<c:url value='/admin/customer?message=insert_failed'/>";
                } else {
                    window.location.href = "<c:url value='/admin/customer?message=update_failed'/>";
                }
            }

        });

    })
</script>
</body>
</html>
