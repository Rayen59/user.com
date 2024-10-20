<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page des utilisateurs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #fff;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .posts {
            margin-top: 20px;
        }
        .post {
            background-color: #1e1e1e;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #444;
            border-radius: 5px;
        }
        img, video {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Posts partagés par l'admin</h1>
    <div class="posts" id="userPosts">
        <!-- Les posts partagés s'afficheront ici -->
    </div>
</div>

<script>
    function getPosts() {
        return JSON.parse(localStorage.getItem('posts')) || [];
    }

    function renderPosts() {
        const posts = getPosts();
        const postsContainer = document.getElementById('userPosts');
        postsContainer.innerHTML = '';
        posts.forEach((post) => {
            postsContainer.innerHTML += `
                <div class="post">
                    <h3>${post.title}</h3>
                    <p>${post.content}</p>
                    ${post.fileUrl ? (post.fileType.startsWith('image') ? `<img src="${post.fileUrl}" alt="Image">` : `<video src="${post.fileUrl}" controls></video>`) : ''}
                </div>
            `;
        });
    }

    window.onload = function() {
        renderPosts();
    };
</script>

</body>
</html>
