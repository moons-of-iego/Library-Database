USE library_project_mod;

CREATE TABLE IF NOT EXISTS AUTHORS (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(512),
    last_name VARCHAR(512)
);

CREATE TABLE IF NOT EXISTS USERS (
    mail_address VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(512),
    last_name VARCHAR(512)
);

CREATE TABLE IF NOT EXISTS LAB (
    lab_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(512)
);

CREATE TABLE IF NOT EXISTS CURRENCY (
    currency_code VARCHAR(10) PRIMARY KEY,
    change_rate_to_eur DECIMAL(10, 6),
    date_rate DATE
);

CREATE TABLE IF NOT EXISTS PUBLISHER (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(512)
);

CREATE TABLE IF NOT EXISTS KEYWORDS (
    keyword VARCHAR(255) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS CATEGORIES (
    category_id VARCHAR(255) PRIMARY KEY,
    category_name VARCHAR(512)
);

CREATE TABLE IF NOT EXISTS PUBLICATION (
    publication_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(512),
    year_of_publication SMALLINT
);

CREATE TABLE IF NOT EXISTS PERIODICS (
    publication_id INT PRIMARY KEY,
    edition VARCHAR(512),
    volume_nb INT,
    review VARCHAR(512),
    publisher_id INT,
    CONSTRAINT uk_periodic_review_volume UNIQUE (review, volume_nb),
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(publisher_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS REGULAR_BOOKS (
    publication_id INT PRIMARY KEY,
    edition VARCHAR(512),
    ISBN VARCHAR(512) UNIQUE,
    publisher_id INT,
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(publisher_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CATEGORIZES (
    category_id VARCHAR(255),
    publication_id INT,
    PRIMARY KEY (category_id, publication_id),
    FOREIGN KEY (category_id) REFERENCES CATEGORIES(category_id) ON DELETE CASCADE,
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS SCIENTIFIC_REPORT (
    publication_id INT PRIMARY KEY,
    identification_nb VARCHAR(512) UNIQUE,
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ECL_THESIS (
    publication_id INT PRIMARY KEY,
    identification_nb VARCHAR(512) UNIQUE,
    author_id INT,
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES AUTHORS(author_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS INDICES (
    keyword VARCHAR(255),
    publication_id INT,
    PRIMARY KEY (keyword, publication_id),
    FOREIGN KEY (keyword) REFERENCES KEYWORDS(keyword) ON DELETE CASCADE,
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE
);

CREATE TABLE WRITES (
    publication_id INT,
    author_id INT,
    PRIMARY KEY (publication_id, author_id),
    FOREIGN KEY (publication_id) REFERENCES REGULAR_BOOKS(publication_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES AUTHORS(author_id) ON DELETE CASCADE
);

CREATE TABLE CONTRIBUTES_TO (
    publication_id INT,
    author_id INT,
    PRIMARY KEY (publication_id, author_id),
    FOREIGN KEY (publication_id) REFERENCES SCIENTIFIC_REPORT(publication_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES AUTHORS(author_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS IS_INTERESTED_BY (
    keyword VARCHAR(255),
    mail_address VARCHAR(255),
    PRIMARY KEY (keyword, mail_address),
    FOREIGN KEY (keyword) REFERENCES KEYWORDS(keyword) ON DELETE CASCADE,
    FOREIGN KEY (mail_address) REFERENCES USERS(mail_address) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS GIVES_ACCESS (
    lab_id INT,
    mail_address VARCHAR(255),
    PRIMARY KEY (lab_id, mail_address),
    FOREIGN KEY (lab_id) REFERENCES LAB(lab_id) ON DELETE CASCADE,
    FOREIGN KEY (mail_address) REFERENCES USERS(mail_address) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS COPIES (
    publication_id INT,
    lab_id INT,
    status VARCHAR(100),
    book_shop VARCHAR(512),
    price DECIMAL(10, 2),
    currency_code VARCHAR(10),
    PRIMARY KEY (publication_id, lab_id),
    FOREIGN KEY (publication_id) REFERENCES PUBLICATION(publication_id) ON DELETE CASCADE,
    FOREIGN KEY (lab_id) REFERENCES LAB(lab_id) ON DELETE CASCADE,
    FOREIGN KEY (currency_code) REFERENCES CURRENCY(currency_code)
);

CREATE TABLE IF NOT EXISTS ISSUES (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    issue_date DATE,
    return_date DATE,
    effective_return_date DATE,
    publication_id INT,
    lab_id INT,
    mail_address VARCHAR(255),
    FOREIGN KEY (publication_id, lab_id) REFERENCES COPIES(publication_id, lab_id) ON DELETE CASCADE,
    FOREIGN KEY (mail_address) REFERENCES USERS(mail_address) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PROPOSITION (
    proposition_id INT AUTO_INCREMENT PRIMARY KEY,
    proposition_date DATE,
    publication_id INT,
    lab_id INT,
    mail_address VARCHAR(255),
    FOREIGN KEY (publication_id, lab_id) REFERENCES COPIES(publication_id, lab_id) ON DELETE CASCADE,
    FOREIGN KEY (mail_address) REFERENCES USERS(mail_address) ON DELETE CASCADE
);