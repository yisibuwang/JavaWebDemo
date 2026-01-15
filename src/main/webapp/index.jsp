<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>仿美团外卖 - 在线订餐</title>
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

        .search-bar {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .search-input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 16px;
        }

        .merchant-section {
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

        .merchant-list {
            padding: 10px;
        }

        .merchant-card {
            display: flex;
            padding: 15px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }

        .merchant-card:last-child {
            border-bottom: none;
        }

        .merchant-image {
            width: 80px;
            height: 80px;
            border-radius: 4px;
            object-fit: cover;
            margin-right: 15px;
            background-color: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .merchant-info {
            flex: 1;
        }

        .merchant-name {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 5px;
        }

        .merchant-meta {
            display: flex;
            font-size: 12px;
            color: #999;
            margin-bottom: 5px;
        }

        .rating {
            color: #ffa500;
            margin-right: 10px;
        }

        .delivery-info {
            color: #666;
        }

        .cart-section {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #ffd200;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            font-size: 24px;
            z-index: 100;
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: red;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        .cart-modal {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: white;
            border-radius: 10px 10px 0 0;
            max-height: 70vh;
            overflow-y: auto;
            z-index: 1000;
            display: none;
        }

        .modal-header {
            padding: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-item {
            padding: 10px 15px;
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
        }

        .order-actions {
            padding: 15px;
            display: flex;
            justify-content: space-between;
        }

        .confirm-btn {
            background: #ffd200;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
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
        <div class="logo">外卖</div>
        <div class="nav">
            <div class="nav-item active" onclick="location.href='index.jsp'">首页</div>
            <div class="nav-item" onclick="location.href='order.jsp'">订单</div>
            <div class="nav-item" onclick="location.href='admin/product.jsp'">后台管理</div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="search-bar">
        <input type="text" class="search-input" placeholder="搜索商家或商品...">
    </div>

    <div class="merchant-section">
        <div class="section-header">推荐商家</div>
        <div class="merchant-list" id="merchantList">
            <div class="loading" id="loadingMerchants">加载中...</div>
        </div>
    </div>
</div>

<div class="cart-section" id="cartIcon">
    🛒
    <div class="cart-count" id="cartCount" style="display:none;">0</div>
</div>

<div class="cart-modal" id="cartModal">
    <div class="modal-header">
        <h3>购物车</h3>
        <span id="closeCart">×</span>
    </div>
    <div id="orderItems">
        <!-- 订单项目将通过JavaScript动态生成 -->
    </div>
    <div class="order-actions">
        <div>总计: ¥<span id="totalPrice">0</span></div>
        <button class="confirm-btn" id="confirmOrder">确认下单</button>
    </div>
</div>

<script src="js/jquery-3.6.1.min.js"></script>
<script>
    // 购物车数据
    let cart = [];

    // 页面加载初始化
    $(function(){
        queryMerchants();  // 查询商家列表
        bindDomEvents();   // 绑定事件
    })

    // 绑定所有DOM事件
    function bindDomEvents(){
        // 购物车图标点击
        $("#cartIcon").click(function(){
            showCart();
        })

        // 关闭购物车按钮
        $("#closeCart").click(function(){
            hideCart();
        })

        // 确认下单按钮
        $("#confirmOrder").click(function(){
            confirmOrder();
        })

        // 搜索框输入事件
        $(".search-input").on("input", function(){
            searchMerchants($(this).val());
        })
    }

    // 查询商家列表（使用jQuery AJAX）
    function queryMerchants(){
        $.ajax({
            type: "GET",
            url: "/index",
            dataType: "json",
            success: function(merchants){
                renderMerchants(merchants);
            },
            error: function(){
                $("#merchantList").html('<div class="loading">加载失败，请刷新重试</div>');
            }
        });
    }

    // 搜索商家
    function searchMerchants(keyword){
        $.ajax({
            type: "GET",
            url: "/search",  // 搜索接口
            data: {
                keyword: keyword
            },
            dataType: "json",
            success: function(merchants){
                renderMerchants(merchants);
            }
        });
    }

    // 渲染商家列表
    function renderMerchants(merchants){
        const merchantList = $("#merchantList");
        merchantList.empty();

        if (merchants.length === 0) {
            merchantList.html('<div class="loading">暂无商家</div>');
            return;
        }

        for(let i=0; i<merchants.length; i++){
            let merchant = merchants[i];
            merchantList.append(
                '<div class="merchant-card" onclick="showMerchantDetail(' + merchant.mid + ')">' +
                '<div class="merchant-image">店铺</div>' +
                '<div class="merchant-info">' +
                '<div class="merchant-name">' + merchant.mname + '</div>' +
                '<div class="merchant-meta">' +
                '<span class="rating">⭐' + merchant.score + '</span>' +
                '<span>' + merchant.address + '</span>' +
                '</div>' +
                '<div class="delivery-info">联系电话: ' + merchant.phone + '</div>' +
                '</div>' +
                '</div>'
            );
        }
    }

    // 显示商家详情（跳转到商家详情页）
    function showMerchantDetail(merchantId){
        window.location.href = 'merchant.jsp?id=' + merchantId;
    }

    // 添加商品到购物车（需要在商家详情页调用）
    function addToCart(product){
        // 查找是否已存在该商品
        let existingItem = cart.find(item => item.id === product.id);

        if(existingItem){
            existingItem.quantity += 1;
        } else {
            cart.push({
                id: product.id,
                name: product.name,
                price: product.price,
                quantity: 1
            });
        }

        updateCartDisplay();
        alert("已添加到购物车");
    }

    // 更新购物车显示
    function updateCartDisplay(){
        const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
        const cartCount = $("#cartCount");

        if(totalItems > 0){
            cartCount.text(totalItems);
            cartCount.show();
        } else {
            cartCount.hide();
        }
    }

    // 显示购物车
    function showCart(){
        if(cart.length === 0){
            alert('购物车为空，请先添加商品');
            return;
        }

        $("#cartModal").show();
        renderOrderItems();
    }

    // 隐藏购物车
    function hideCart(){
        $("#cartModal").hide();
    }

    // 渲染订单项目
    function renderOrderItems(){
        const orderItemsContainer = $("#orderItems");
        orderItemsContainer.empty();

        for(let i=0; i<cart.length; i++){
            let item = cart[i];
            orderItemsContainer.append(
                '<div class="order-item">' +
                '<div>' + item.name + '</div>' +
                '<div>¥' + item.price + ' × ' + item.quantity + '</div>' +
                '</div>'
            );
        }

        updateTotalPrice();
    }

    // 更新总价
    function updateTotalPrice(){
        const totalPrice = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        $("#totalPrice").text(totalPrice.toFixed(2));
    }

    // 确认下单
    function confirmOrder(){
        if(cart.length === 0){
            alert('请先添加商品到购物车');
            return;
        }

        // 这里可以改成发送订单数据到后端
        // 暂时使用模拟提交
        $.ajax({
            type: "POST",
            url: "/order/create",
            data: {
                items: JSON.stringify(cart)
            },
            dataType: "json",
            success: function(response){
                if(response.success){
                    alert('订单提交成功！感谢您的购买');
                    cart = []; // 清空购物车
                    updateCartDisplay();
                    hideCart();
                } else {
                    alert('订单提交失败：' + response.message);
                }
            }
        });
    }

    // 获取当前登录用户（如果需要）
    function getCurrentUser(){
        // 这里可以从cookie或session获取用户信息
        return {
            userId: 1,
            userName: "测试用户"
        };
    }
</script>
</body>
</html>