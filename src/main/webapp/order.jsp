<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单列表 - 外卖平台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .header {
            background-color: #ffd200;
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #000;
        }

        .nav {
            display: flex;
            gap: 30px;
        }

        .nav-item {
            cursor: pointer;
            font-weight: 500;
        }

        .main-content {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .order-section {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .section-header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            font-size: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-input {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 200px;
        }

        .order-list {
            padding: 10px;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th {
            background-color: #f8f9fa;
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
            font-weight: 600;
        }

        .order-table td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        .order-table tr:hover {
            background-color: #f9f9f9;
        }

        .status-pending {
            color: #ff9800;
            background-color: #fff3e0;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .status-processing {
            color: #2196f3;
            background-color: #e3f2fd;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .status-completed {
            color: #4caf50;
            background-color: #e8f5e9;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .status-cancelled {
            color: #f44336;
            background-color: #ffebee;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .action-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            margin-right: 5px;
        }

        .view-btn {
            background-color: #2196f3;
            color: white;
        }

        .cancel-btn {
            background-color: #ff5722;
            color: white;
        }

        .confirm-btn {
            background-color: #4caf50;
            color: white;
        }

        .order-empty {
            padding: 40px;
            text-align: center;
            color: #999;
        }

        .loading {
            text-align: center;
            padding: 20px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-content">
        <div class="logo" onclick="location.href='index.jsp'">外卖</div>
        <div class="nav">
            <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
            <div class="nav-item" onclick="location.href='order.jsp'">订单</div>
            <div class="nav-item" onclick="location.href='admin/product.jsp'">后台管理</div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="order-section">
        <div class="section-header">
            <span>我的订单</span>
            <input type="text" class="search-input" placeholder="搜索订单号..." id="searchInput">
        </div>
        <div class="order-list" id="orderList">
            <div class="loading">加载中...</div>
        </div>
    </div>
</div>

<script src="js/jquery-3.6.1.min.js"></script>
<script>
    // 页面加载初始化
    $(function(){
        queryOrders();  // 查询订单列表
        bindDomEvents(); // 绑定事件
    })

    // 绑定所有DOM事件
    function bindDomEvents(){
        // 搜索框输入事件
        $("#searchInput").on("input", function(){
            searchOrders($(this).val());
        })
    }

    // 查询订单列表
    function queryOrders(){
        $.ajax({
            type: "GET",
            url: "/order",
            dataType: "json",
            success: function(orders){
                renderOrders(orders);
            },
            error: function(){
                $("#orderList").html('<div class="order-empty">加载失败，请刷新重试</div>');
            }
        });
    }

    // 搜索订单
    function searchOrders(keyword){
        $.ajax({
            type: "GET",
            url: "/search",
            data: {
                keyword: keyword,
                action: 'order'
            },
            dataType: "json",
            success: function(orders){
                renderOrders(orders);
            }
        });
    }

    // 渲染订单列表
    function renderOrders(orders){
        const orderList = $("#orderList");
        orderList.empty();

        if (orders.length === 0) {
            orderList.html('<div class="order-empty">暂无订单</div>');
            return;
        }

        // 创建表格
        let table = '<table class="order-table">' +
            '<thead>' +
            '<tr>' +
            '<th>订单编号</th>' +
            '<th>购物车ID</th>' +
            '<th>订单状态</th>' +
            '<th>下单时间</th>' +
            '<th>操作</th>' +
            '</tr>' +
            '</thead>' +
            '<tbody>';

        for(let i=0; i<orders.length; i++){
            let order = orders[i];
            let statusClass = getStatusClass(order.status);
            let statusText = getStatusText(order.status);

            table += '<tr>' +
                '<td>' + order.ordersid + '</td>' +
                '<td>' + order.cartid + '</td>' +
                '<td><span class="' + statusClass + '">' + statusText + '</span></td>' +
                '<td>' + formatDateTime(order.createTime) + '</td>' +
                '<td>' +
                '<button class="action-btn view-btn" onclick="viewOrderDetail(' + order.ordersid + ')">查看</button>' +
                getActionButtons(order) +
                '</td>' +
                '</tr>';
        }

        table += '</tbody></table>';
        orderList.html(table);
    }

    // 根据状态获取CSS类
    function getStatusClass(status){
        switch(status){
            case 'pending': return 'status-pending';
            case 'processing': return 'status-processing';
            case 'completed': return 'status-completed';
            case 'cancelled': return 'status-cancelled';
            default: return 'status-pending';
        }
    }

    // 根据状态获取文本
    function getStatusText(status){
        switch(status){
            case 'pending': return '待处理';
            case 'processing': return '处理中';
            case 'completed': return '已完成';
            case 'cancelled': return '已取消';
            default: return '待处理';
        }
    }

    // 根据订单状态获取操作按钮
    function getActionButtons(order){
        let buttons = '';

        if(order.status === 'pending'){
            buttons += '<button class="action-btn cancel-btn" onclick="updateOrderStatus(' + order.ordersid + ', \'cancelled\')">取消</button>' +
                '<button class="action-btn confirm-btn" onclick="updateOrderStatus(' + order.ordersid + ', \'processing\')">确认</button>';
        }
        else if(order.status === 'processing'){
            buttons += '<button class="action-btn confirm-btn" onclick="updateOrderStatus(' + order.ordersid + ', \'completed\')">完成</button>';
        }

        return buttons;
    }

    // 格式化日期时间
    function formatDateTime(timestamp){
        if(!timestamp) return '-';

        let date = new Date(timestamp);
        let year = date.getFullYear();
        let month = (date.getMonth() + 1).toString().padStart(2, '0');
        let day = date.getDate().toString().padStart(2, '0');
        let hours = date.getHours().toString().padStart(2, '0');
        let minutes = date.getMinutes().toString().padStart(2, '0');

        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
    }

    // 查看订单详情
    function viewOrderDetail(orderId){
        window.location.href = 'order-detail.jsp?id=' + orderId;
    }

    // 更新订单状态
    function updateOrderStatus(orderId, newStatus){
        let statusText = getStatusText(newStatus);

        if(!confirm('确定要将订单状态更新为"' + statusText + '"吗？')){
            return;
        }

        $.ajax({
            type: "PUT",
            url: "/api/order/status",
            data: {
                orderId: orderId,
                status: newStatus
            },
            dataType: "json",
            success: function(response){
                if(response.success){
                    alert('订单状态更新成功');
                    queryOrders(); // 重新加载订单列表
                } else {
                    alert('更新失败：' + response.message);
                }
            },
            error: function(){
                alert('网络错误，请稍后重试');
            }
        });
    }

    // 获取当前用户ID（假设从session或cookie获取）
    function getCurrentUserId(){
        // 这里可以从cookie或session获取用户信息
        return 1; // 假设用户ID为1
    }
</script>
</body>
</html>