<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理系统</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00ff88;
            --secondary-color: #8a2be2;
            --bg-dark: #0a0a1a;
            --bg-light: #f0f4f8;
            --text-dark: #e0e0e0; /* Brighter for dark mode */
            --text-light: #222222; /* Darker for light mode */
            --card-bg-dark: rgba(20, 20, 40, 0.7);
            --card-bg-light: rgba(255, 255, 255, 0.9);
            --shadow-dark: 0 8px 32px rgba(0, 255, 136, 0.2);
            --shadow-light: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        [data-theme="dark"] {
            --bg-color: var(--bg-dark);
            --text-color: var(--text-dark);
            --card-bg: var(--card-bg-dark);
            --shadow: var(--shadow-dark);
        }

        [data-theme="light"] {
            --bg-color: var(--bg-light);
            --text-color: var(--text-light);
            --card-bg: var(--card-bg-light);
            --shadow: var(--shadow-light);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', 'Microsoft YaHei', sans-serif;
        }

        body {
            background: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            transition: background 0.3s, color 0.3s;
        }

        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        nav {
            background: linear-gradient(45deg, #1e1e3f, #2a2a5a);
            padding: 20px 0;
            text-align: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow);
        }

        nav a {
            color: var(--text-dark);
            margin: 0 25px;
            text-decoration: none;
            font-family: 'Orbitron', sans-serif;
            font-size: 18px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s, transform 0.3s;
        }

        nav a:hover {
            color: var(--primary-color);
            transform: translateY(-2px);
        }

        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            z-index: 2000;
            color: var(--text-color);
        }

        .container {
            margin: 40px auto;
            max-width: 1000px;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: var(--shadow);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 30px;
            font-size: 32px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 0 0 10px var(--primary-color);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        label {
            font-size: 16px;
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 8px;
            display: block;
        }

        input, select, button {
            padding: 14px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            font-size: 16px;
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-color);
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus, select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 10px var(--primary-color);
            outline: none;
        }

        button {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border: none;
            cursor: pointer;
            font-weight: 500;
            position: relative;
            overflow: hidden;
            transition: transform 0.3s;
        }

        button:hover {
            transform: scale(1.05);
        }

        button::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }

        button:active::after {
            width: 200px;
            height: 200px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background: rgba(255, 255, 255, 0.05);
        }

        th, td {
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 16px;
            text-align: center;
        }

        th {
            background: linear-gradient(45deg, #1e1e3f, #2a2a5a);
            color: var(--text-dark);
            font-family: 'Orbitron', sans-serif;
            font-weight: 600;
            font-size: 16px;
        }

        td {
            background: rgba(255, 255, 255, 0.05);
            font-size: 16px;
            font-weight: 500;
        }

        .actions a {
            color: var(--primary-color);
            text-decoration: none;
            margin: 0 10px;
            font-size: 14px;
            transition: color 0.3s, transform 0.3s;
        }

        .actions a:hover {
            color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .error-message {
            background: rgba(211, 47, 47, 0.2);
            color: #ff6b6b;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border: 1px solid #ff6b6b;
        }

        .success-message {
            background: rgba(56, 142, 60, 0.2);
            color: #00ff88;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border: 1px solid #00ff88;
        }

        .category-form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
            flex-wrap: wrap;
        }

        .category-form .form-group {
            flex: 1;
            min-width: 200px;
        }

        .category-form button {
            padding: 14px 20px;
            flex-shrink: 0;
        }

        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 25px;
            }
            nav a {
                margin: 0 15px;
                font-size: 16px;
            }
            h2 {
                font-size: 28px;
            }
            input, select, button {
                font-size: 14px;
                padding: 12px;
            }
            th, td {
                font-size: 14px;
                padding: 12px;
            }
            .theme-toggle {
                top: 15px;
                right: 15px;
                font-size: 20px;
            }
            .category-form {
                flex-direction: column;
                align-items: stretch;
            }
            .category-form .form-group {
                min-width: auto;
            }
            .category-form button {
                width: 100%;
            }
        }
    </style>
</head>
<body data-theme="dark">
    <div id="particles-js"></div>
    <button class="theme-toggle" onclick="toggleTheme()">🌙</button>
    <nav>
        <a href="#user-management">用户管理</a>
        <a href="#news-management">新闻管理</a>
        <a href="#movie-upload">影片上传</a>
        <a href="#category-management">影片类别管理</a>
    </nav>
    
    <!-- 用户管理 -->
    <div class="container" id="user-management">
        <h2>用户管理</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>操作</th>
            </tr>
            <tr>
                <td>1</td>
                <td>admin</td>
                <td class="actions">
                    <a href="#">编辑</a>
                    <a href="#">删除</a>
                </td>
            </tr>
        </table>
    </div>

    <!-- 新闻管理 -->
    <div class="container" id="news-management">
        <h2>新闻管理</h2>
        <c:if test="${not empty newsErrorMessage}">
            <p class="error-message">${newsErrorMessage}</p>
        </c:if>
        <c:if test="${not empty newsSuccessMessage}">
            <p class="success-message">${newsSuccessMessage}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/addNews" method="post">
            <div class="form-group">
                <label for="newsTitle">新闻标题</label>
                <input type="text" id="newsTitle" name="title" placeholder="请输入新闻标题" required>
            </div>
            <div class="form-group">
                <label for="publishTime">发布时间</label>
                <input type="datetime-local" id="publishTime" name="publishTime" required>
            </div>
            <div class="form-group">
                <label for="newsDescription">新闻描述</label>
                <input type="text" id="newsDescription" name="description" placeholder="请输入新闻描述">
            </div>
            <button type="submit">添加新闻</button>
        </form>
        <table>
            <tr>
                <th>新闻标题</th>
                <th>发布时间</th>
                <th>操作</th>
            </tr>
        </table>
    </div>

    <!-- 影片上传 -->
    <div class="container" id="movie-upload">
        <h2>影片上传</h2>
        <c:if test="${not empty movieErrorMessage}">
            <p class="error-message">${movieErrorMessage}</p>
        </c:if>
        <c:if test="${not empty movieSuccessMessage}">
            <p class="success-message">${movieSuccessMessage}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/addMovie" method="post">
            <div class="form-group">
                <label for="movieName">影片名称</label>
                <input type="text" id="movieName" name="movieName" placeholder="请输入影片名称" required>
            </div>
            <div class="form-group">
                <label for="categoryId">影片分类</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="" disabled selected>请选择分类</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="movieDescription">影片描述</label>
                <input type="text" id="movieDescription" name="description" placeholder="请输入影片描述">
            </div>
            <button type="submit">上传影片</button>
        </form>
    </div>

    <!-- 影片类别管理 -->
    <div class="container" id="category-management">
        <h2>影片类别管理</h2>
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>
        <c:if test="${not empty queryMessage}">
            <p class="success-message">${queryMessage}</p>
        </c:if>
        <div class="category-form">
            <form action="${pageContext.request.contextPath}/addCategory" method="post" class="form-group">
                <div class="form-group">
                    <label for="categoryName">类别名称</label>
                    <input type="text" id="categoryName" name="name" placeholder="请输入类别名称" required>
                </div>
                <button type="submit">添加类别</button>
            </form>
            <form action="${pageContext.request.contextPath}/addCategory" method="get">
                <input type="hidden" name="action" value="query">
                <button type="submit">查询类别</button>
            </form>
        </div>
        <c:if test="${not empty categories}">
            <table>
                <tr>
                    <th>ID</th>
                    <th>类别名称</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td>${category.id}</td>
                        <td>${category.name}</td>
                        <td class="actions">
                            <a href="#">编辑</a>
                            <a href="#">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script>
        particlesJS('particles-js', {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: ['#00ff88', '#8a2be2'] },
                shape: { type: 'circle' },
                opacity: { value: 0.5, random: true },
                size: { value: 3, random: true },
                line_linked: { enable: true, distance: 150, color: '#00ff88', opacity: 0.4, width: 1 },
                move: { enable: true, speed: 2, direction: 'none', random: false }
            },
            interactivity: {
                detect_on: 'canvas',
                events: { onhover: { enable: true, mode: 'repulse' }, onclick: { enable: true, mode: 'push' } },
                modes: { repulse: { distance: 100 }, push: { particles_nb: 4 } }
            },
            retina_detect: true
        });

        function toggleTheme() {
            const body = document.body;
            const currentTheme = body.getAttribute('data-theme');
            body.setAttribute('data-theme', currentTheme === 'dark' ? 'light' : 'dark');
            document.querySelector('.theme-toggle').textContent = currentTheme === 'dark' ? '☀️' : '🌙';
        }

        // Smooth scrolling for navigation links
        document.querySelectorAll('nav a').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const targetId = this.getAttribute('href').substring(1);
                const targetElement = document.getElementById(targetId);
                if (targetElement) {
                    const navHeight = document.querySelector('nav').offsetHeight;
                    const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - navHeight;
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                }
            });
        });
    </script>
</body>
</html>