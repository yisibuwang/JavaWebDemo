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
        }

        .order-list {
            padding: 10px;
        }

        .order-card {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        .order-card:last-child {
            border-bottom: none;
        }

        .order-info {
            font-size: 14px;
            margin-bottom: 10px;
        }

        .order-status {
            font-size: 14px;
            color: #ff4d4f;
            font-weight: 600;
        }

        .order-empty {
            padding: 40px;
            text-align: center;
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
                <div class="nav-item" onclick="location.href='#'">我的</div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="order-section">
            <div class="section-header">我的订单</div>
            <div class="order-list" id="orderList">
                <!-- 订单将通过JavaScript动态生成 -->
            </div>
        </div>
    </div>

    <script src="js/jquery-3.6.1.min.js"></script>
    <script>
        // 加载订单列表
        async function loadOrders() {
            try {
                const response = await fetch('/api/order');
                const orders = await response.json();
                
                const orderList = document.getElementById('orderList');
                orderList.innerHTML = '';
                
                if (orders.length === 0) {
                    orderList.innerHTML = '<div class="order-empty">暂无订单</div>';
                    return;
                }
                
                orders.forEach(order => {
                    const orderCard = document.createElement('div');
                    orderCard.className = 'order-card';
                    
                    orderCard.innerHTML = `
                        <div class="order-info">订单编号: ${order.ordersid}</div>
                        <div class="order-info">购物车ID: ${order.cartid}</div>
                        <div class="order-status">订单状态: 已提交</div>
                    `;
                    
                    orderList.appendChild(orderCard);
                });
            } catch (error) {
                console.error('加载订单失败:', error);
                document.getElementById('orderList').innerHTML = '<div class="order-empty">加载失败，请刷新重试</div>';
            }
        }

        // 事件绑定
        document.addEventListener('DOMContentLoaded', function() {
            loadOrders();
        });
    </script>
</body>
</html>
