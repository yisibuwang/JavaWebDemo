<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商家详情 - 外卖平台</title>
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

        .merchant-header {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .merchant-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .merchant-info {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .product-section {
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

        .product-list {
            padding: 10px;
        }

        .product-card {
            display: flex;
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        .product-card:last-child {
            border-bottom: none;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 5px;
        }

        .product-description {
            font-size: 14px;
            color: #999;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 18px;
            font-weight: 600;
            color: #ff4d4f;
        }

        .product-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            justify-content: center;
        }

        .add-btn {
            background: #ffd200;
            border: none;
            padding: 5px 15px;
            border-radius: 15px;
            cursor: pointer;
            font-size: 14px;
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

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .quantity-btn {
            width: 24px;
            height: 24px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity {
            min-width: 30px;
            text-align: center;
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
        <div class="merchant-header">
            <div class="merchant-name" id="merchantName">加载中...</div>
            <div class="merchant-info" id="merchantInfo">加载中...</div>
        </div>

        <div class="product-section">
            <div class="section-header">商品列表</div>
            <div class="product-list" id="productList">
                <!-- 商品将通过JavaScript动态生成 -->
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
        
        // 获取URL参数
        function getUrlParam(name) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }
        
        // 加载商家信息
        async function loadMerchantInfo() {
            const merchantId = getUrlParam('id');
            if (!merchantId) {
                document.getElementById('merchantName').textContent = '商家ID不存在';
                document.getElementById('merchantInfo').textContent = '请从首页选择商家';
                return;
            }
            
            try {
                const response = await fetch('/api/merchant');
                const merchants = await response.json();
                const merchant = merchants.find(m => m.mid == merchantId);
                
                if (merchant) {
                    document.getElementById('merchantName').textContent = merchant.mname;
                    document.getElementById('merchantInfo').textContent = `电话: ${merchant.phone} | 地址: ${merchant.address} | 评分: ${merchant.score}`;
                } else {
                    document.getElementById('merchantName').textContent = '商家不存在';
                    document.getElementById('merchantInfo').textContent = '请从首页选择商家';
                }
            } catch (error) {
                console.error('加载商家信息失败:', error);
                document.getElementById('merchantName').textContent = '加载失败';
                document.getElementById('merchantInfo').textContent = '请刷新页面重试';
            }
        }
        
        // 加载商品列表
        async function loadProducts() {
            const merchantId = getUrlParam('id');
            if (!merchantId) {
                document.getElementById('productList').innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">商家ID不存在，请从首页选择商家</div>';
                return;
            }
            
            try {
                const response = await fetch('/api/product');
                const products = await response.json();
                
                // 根据商家ID过滤商品
                const filteredProducts = products.filter(product => product.mid == merchantId);
                
                const productList = document.getElementById('productList');
                productList.innerHTML = '';
                
                if (filteredProducts.length === 0) {
                    productList.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">暂无商品</div>';
                    return;
                }
                
                filteredProducts.forEach(product => {
                    const productCard = document.createElement('div');
                    productCard.className = 'product-card';
                    
                    productCard.innerHTML = `
                        <div class="product-info">
                            <div class="product-name">${product.productname}</div>
                            <div class="product-description">${product.description}</div>
                            <div class="product-price">¥${product.price}</div>
                        </div>
                        <div class="product-actions">
                            <button class="add-btn" onclick="addToCart(${product.productid}, '${product.productname}', ${product.price})">+</button>
                        </div>
                    `;
                    
                    productList.appendChild(productCard);
                });
            } catch (error) {
                console.error('加载商品失败:', error);
                document.getElementById('productList').innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">加载失败，请刷新重试</div>';
            }
        }

        // 添加到购物车
        function addToCart(productId, productName, price) {
            const existingItem = cart.find(item => item.productId === productId);
            
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({
                    productId: productId,
                    name: productName,
                    price: price,
                    quantity: 1
                });
            }
            
            updateCartDisplay();
            alert('已添加到购物车');
        }

        // 更新购物车显示
        function updateCartDisplay() {
            const cartCount = document.getElementById('cartCount');
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            
            if (totalItems > 0) {
                cartCount.textContent = totalItems;
                cartCount.style.display = 'flex';
            } else {
                cartCount.style.display = 'none';
            }
        }

        // 显示购物车
        function showCart() {
            if (cart.length === 0) {
                alert('购物车为空，请先添加商品');
                return;
            }
            
            document.getElementById('cartModal').style.display = 'block';
            renderOrderItems();
        }

        // 渲染订单项目
        function renderOrderItems() {
            const orderItemsContainer = document.getElementById('orderItems');
            orderItemsContainer.innerHTML = '';
            
            cart.forEach(item => {
                const orderItem = document.createElement('div');
                orderItem.className = 'order-item';
                orderItem.innerHTML = `
                    <div>${item.name}</div>
                    <div>
                        <div style="margin-bottom: 5px;">¥${item.price}</div>
                        <div class="quantity-controls">
                            <button class="quantity-btn" onclick="updateQuantity(${item.productId}, -1)">-</button>
                            <span class="quantity">${item.quantity}</span>
                            <button class="quantity-btn" onclick="updateQuantity(${item.productId}, 1)">+</button>
                        </div>
                    </div>
                `;
                orderItemsContainer.appendChild(orderItem);
            });
            
            updateTotalPrice();
        }

        // 更新商品数量
        function updateQuantity(productId, change) {
            const item = cart.find(item => item.productId === productId);
            if (item) {
                item.quantity += change;
                if (item.quantity <= 0) {
                    cart = cart.filter(item => item.productId !== productId);
                }
                renderOrderItems();
                updateCartDisplay();
            }
        }

        // 更新总价
        function updateTotalPrice() {
            const totalPrice = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            document.getElementById('totalPrice').textContent = totalPrice.toFixed(2);
        }

        // 提交订单
        async function submitOrder() {
            if (cart.length === 0) {
                alert('请先添加商品到购物车');
                return;
            }
            
            // 这里可以添加提交订单的API调用
            alert('订单提交成功！感谢您的购买');
            cart = []; // 清空购物车
            updateCartDisplay();
            document.getElementById('cartModal').style.display = 'none';
        }

        // 事件绑定
        document.addEventListener('DOMContentLoaded', function() {
            loadMerchantInfo();
            loadProducts();
            updateCartDisplay();
            
            document.getElementById('cartIcon').addEventListener('click', showCart);
            document.getElementById('closeCart').addEventListener('click', function() {
                document.getElementById('cartModal').style.display = 'none';
            });
            
            document.getElementById('confirmOrder').addEventListener('click', submitOrder);
        });
    </script>
</body>
</html>
