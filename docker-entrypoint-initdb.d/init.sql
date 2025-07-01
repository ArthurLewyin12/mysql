USE myapp;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('auteur', 'relecteur', 'admin') DEFAULT 'auteur',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    abstract TEXT,
    author_id INT NOT NULL,
    pdf_path VARCHAR(255) NOT NULL,
    original_filename VARCHAR(255),
    status ENUM('soumis', 'en_relecture', 'accepte', 'rejete') DEFAULT 'soumis',
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    validated_at DATETIME NULL,
    deleted_at DATETIME DEFAULT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE annotations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    content TEXT NOT NULL,
    page_number INT,
    position_x FLOAT NULL,
    position_y FLOAT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id)
);

CREATE TABLE validations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    decision ENUM('accepte', 'rejete') NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id)
);

CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    target_type VARCHAR(50) NULL,
    target_id INT NULL,
    metadata TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
