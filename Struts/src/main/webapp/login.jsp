<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>登录页面</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00ff88;
            --secondary-color: #8a2be2;
            --bg-dark: #0a0a1a;
            --text-color: #f0f0f0;
            --card-bg: rgba(20, 20, 40, 0.85);
            --shadow: 0 8px 32px rgba(0, 255, 136, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', 'Microsoft YaHei', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #0a0a1a 0%, #1e1e3f 100%);
            color: var(--text-color);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            overflow: hidden;
        }

        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .login-container {
            width: 350px;
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            padding: 30px;
            border-radius: 10px;
            box-shadow: var(--shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            text-shadow: 0 0 10px var(--primary-color);
            animation: pulse 2s infinite ease-in-out;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .login-form label {
            color: var(--text-color);
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
        }

        .login-form input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.15);
            color: var(--text-color);
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .login-form input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 10px var(--primary-color);
        }

        .login-form .submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 5px;
            color: var(--text-color);
            font-size: 16px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .login-form .submit:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px var(--primary-color);
        }

        .login-form .submit::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }

        .login-form .submit:active::after {
            width: 200px;
            height: 200px;
        }

        .action-error {
            color: #ff6b6b;
            background: rgba(211, 47, 47, 0.3);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
            border: 1px solid #ff6b6b;
        }

        @media (max-width: 480px) {
            .login-container {
                width: 90%;
                padding: 20px;
            }
            h2 {
                font-size: 20px;
            }
            .login-form input,
            .login-form .submit {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div id="particles-js"></div>
    <div class="login-container">
        <h2>电影后台管理系统</h2>
        <s:actionerror cssClass="action-error"/>
        <s:form action="login" cssClass="login-form">
            <s:textfield name="username" label="用户名"/>
            <s:password name="password" label="密码"/>
            <s:submit value="登录" cssClass="submit"/>
        </s:form>
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
    </script>
</body>
</html>