CREATE DATABASE yacht_game;

USE yacht_game;

-- Player 테이블: 플레이어 정보 저장
CREATE TABLE Player (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL
);

-- Game 테이블: 게임 정보 저장
CREATE TABLE Game (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    turn INT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

-- Score 테이블: 각 플레이어의 점수 저장
CREATE TABLE Score (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    category VARCHAR(50) NOT NULL,
    score INT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

-- Player 테이블에 인덱스 추가
CREATE INDEX idx_player_name ON Player(player_name);

-- Score 테이블에 인덱스 추가
CREATE INDEX idx_player_category ON Score(player_id, category);

-- Score 테이블에서 유일한 조합 제약 조건 추가
ALTER TABLE Score
ADD CONSTRAINT unique_player_category UNIQUE (player_id, category);

-- Game 테이블에 제약 조건 추가
ALTER TABLE Game
ADD CONSTRAINT fk_player
FOREIGN KEY (player_id) REFERENCES Player(player_id)
ON DELETE CASCADE;  -- 플레이어가 삭제되면 관련된 게임 정보도 삭제됨

-- Score 테이블에 제약 조건 추가
ALTER TABLE Score
ADD CONSTRAINT fk_player_score
FOREIGN KEY (player_id) REFERENCES Player(player_id)
ON DELETE CASCADE;  -- 플레이어가 삭제되면 관련된 점수도 삭제됨

-- 게임 상태를 저장하는 테이블
CREATE TABLE GameStatus (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL, -- 예: 'In Progress', 'Completed'
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- 점수 기록 히스토리 테이블
CREATE TABLE ScoreHistory (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT,
    category VARCHAR(50) NOT NULL,
    score INT NOT NULL,
    score_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);

DELIMITER //

CREATE PROCEDURE GetPlayerScores(IN p_player_id INT)
BEGIN
    SELECT * FROM Score WHERE player_id = p_player_id;
END //

DELIMITER ;

select * from yacht_game;