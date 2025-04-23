<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加成功</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00ff88;
            --secondary-color: #8a2be2;
            --bg-dark: #0a0a1a;
            --text-color: #f0f0f0;
            --card-bg: rgba(20, 20, 40, 0.9);
            --shadow: 0 8px 32px rgba(0, 255, 136, 0.3);
            --metallic-border: linear-gradient(45deg, #1e1e3f, #2a2a5a);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', 'Microsoft YaHei', sans-serif;
        }

        body {
            background: var(--bg-dark);
            color: var(--text-color);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            overflow: hidden;
        }

        #digital-rain {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .success-container {
            width: 400px;
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 12px;
            box-shadow: var(--shadow);
            border: 2px solid transparent;
            background-clip: padding-box;
            position: relative;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        .success-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            z-index: -1;
            background: var(--metallic-border);
            border-radius: 14px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            font-size: 28px;
            margin-bottom: 30px;
            text-shadow: 0 0 10px var(--primary-color);
            animation: pulse 2s infinite ease-in-out;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .links {
            margin-top: 20px;
        }

        .links a {
            color: var(--primary-color);
            text-decoration: none;
            font-family: 'Orbitron', sans-serif;
            font-size: 16px;
            margin: 0 15px;
            transition: color 0.3s, transform 0.3s, text-shadow 0.3s;
            position: relative;
        }

        .links a:hover {
            color: var(--secondary-color);
            transform: translateY(-2px);
            text-shadow: 0 0 15px var(--secondary-color);
        }

        .links a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--secondary-color);
            transition: width 0.3s;
        }

        .links a:hover::after {
            width: 100%;
        }

        @media (max-width: 480px) {
            .success-container {
                width: 90%;
                padding: 20px;
            }
            h2 {
                font-size: 24px;
            }
            .links a {
                font-size: 14px;
                margin: 0 10px;
            }
        }
    </style>
</head>
<body>
    <canvas id="digital-rain"></canvas>
    <div class="success-container">
        <h2>类别添加成功！</h2>
        <div class="links">
            <a href="addCategory.jsp">继续添加</a> | <a href="main.jsp">返回首页</a>
        </div>
    </div>

    <script>
        // Heavy Digital Rain Effect
        const canvas = document.getElementById('digital-rain');
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()日本語';
        const fontSize = 12;
        const columns = Math.floor(canvas.width / fontSize);
        const drops = [];
        const colors = ['#00ff88', '#8a2be2'];

        // Initialize drops with random starting positions
        for (let x = 0; x < columns; x++) {
            drops[x] = {
                y: Math.floor(Math.random() * canvas.height / fontSize),
                speed: 1 + Math.random() * 2,
                color: colors[Math.floor(Math.random() * colors.length)]
            };
        }

        function draw() {
            // Semi-transparent background for fading trails
            ctx.fillStyle = 'rgba(10, 10, 26, 0.15)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            for (let i = 0; i < drops.length; i++) {
                const text = chars.charAt(Math.floor(Math.random() * chars.length));
                ctx.fillStyle = drops[i].color;
                ctx.font = `${fontSize}px monospace`;
                ctx.fillText(text, i * fontSize, drops[i].y * fontSize);

                // Move drop down
                drops[i].y += drops[i].speed;

                // Reset drop to top with new color if it reaches bottom
                if (drops[i].y * fontSize > canvas.height && Math.random() > 0.95) {
                    drops[i] = {
                        y: 0,
                        speed: 1 + Math.random() * 2,
                        color: colors[Math.floor(Math.random() * colors.length)]
                    };
                }
            }
        }

        // Faster animation for heavy rain effect
        setInterval(draw, 25);

        window.addEventListener('resize', () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            // Recalculate columns on resize
            drops.length = Math.floor(canvas.width / fontSize);
            for (let x = drops.length - 1; x >= 0; x--) {
                drops[x] = {
                    y: Math.floor(Math.random() * canvas.height / fontSize),
                    speed: 1 + Math.random() * 2,
                    color: colors[Math.floor(Math.random() * colors.length)]
                };
            }
        });
    </script>
</body>
</html>