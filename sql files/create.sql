SET GLOBAL event_scheduler = ON;


CREATE TABLE Player (
p_id VARCHAR(7), name VARCHAR(25) NOT NULL, age INTEGER NOT NULL, nationality VARCHAR(20) NOT NULL,
PRIMARY KEY(p_id)
);

CREATE TABLE Owner(
o_id VARCHAR(7) NOT NULL, name VARCHAR(20) NOT NULL,
PRIMARY KEY(o_id)
);

CREATE TABLE Team(
t_id VARCHAR(7), name VARCHAR(20) NOT NULL, money_spent DECIMAL(2,2), home_ground VARCHAR(50) NOT NULL, o_id VARCHAR(7) NOT NULL,
PRIMARY KEY(t_id),
FOREIGN KEY (o_id) REFERENCES Owner(o_id) ON DELETE CASCADE,
CONSTRAINT chk_team CHECK (money_spent < 50)
);

CREATE TABLE Coach(
c_id VARCHAR(7),t_id VARCHAR(7), name VARCHAR(20) NOT NULL, domain VARCHAR(15) NOT NULL,
PRIMARY KEY(c_id),
FOREIGN KEY(t_id) REFERENCES Team(t_id) ON DELETE CASCADE
);

CREATE TABLE Venue(
v_id VARCHAR(7), name VARCHAR(50) NOT NULL,
PRIMARY KEY(v_id)
);

CREATE TABLE Umpire(
u_id VARCHAR(7), name VARCHAR(20) NOT NULL, nationality VARCHAR(20) NOT NULL, experience INTEGER NOT NULL,
PRIMARY KEY(u_id)
);

CREATE TABLE C_Match(
m_id VARCHAR(7), stage VARCHAR(15) NOT NULL, team1 VARCHAR(7), team2 VARCHAR(7), m_date DATE NOT NULL, toss_won_by VARCHAR(7) NOT NULL, result VARCHAR(7) NOT NULL, v_id VARCHAR(7) NOT NULL, u_id VARCHAR(7),
PRIMARY KEY(m_id),
FOREIGN KEY (v_id) REFERENCES Venue(v_id),
FOREIGN KEY (u_id) REFERENCES Umpire(u_id)
);

CREATE TABLE Plays(
p_id VARCHAR(7), t_id VARCHAR(7) NOT NULL, c_year ENUM(2013,2014),
FOREIGN KEY(p_id)REFERENCES Player(p_id),	
FOREIGN KEY (t_id) REFERENCES Team(t_id),
PRIMARY KEY(p_id,t_id,c_year)
);

CREATE TABLE captain(
p_id VARCHAR(7), t_id VARCHAR(7) NOT NULL, c_year ENUM(2013,2014),
FOREIGN KEY (p_id) REFERENCES Player(p_id),
FOREIGN KEY (t_id) REFERENCES Team(t_id),
PRIMARY KEY(p_id,t_id,c_year)
);

CREATE TABLE P_award( 
pa_id VARCHAR(7),p_id VARCHAR(7), name VARCHAR(20) NOT NULL, c_year ENUM(2013,2014),
FOREIGN KEY(p_id) REFERENCES Player(p_id),
PRIMARY KEY(pa_id,c_year)
);

CREATE TABLE T_award(
ta_id VARCHAR(7),t_id VARCHAR(7), name VARCHAR(20) NOT NULL, c_year ENUM(2013,2014),
FOREIGN KEY(t_id) REFERENCES Team(t_id) ,
PRIMARY KEY(ta_id,c_year)
);


--Insered for kohli , warner ,watson, malinga 
CREATE TABLE Player_stats(
p_id VARCHAR(7), m_id VARCHAR(7) NOT NULL, runs INTEGER NOT NULL, wickets INTEGER NOT NULL, catches INTEGER NOT NULL, sixes INTEGER NOT NULL, fours INTEGER NOT NULL, strike_rate DECIMAL NOT NULL,
FOREIGN KEY (p_id) REFERENCES Player(p_id),
FOREIGN KEY (m_id) REFERENCES C_Match(m_id),
PRIMARY KEY(p_id)
);


CREATE EVENT UA ON SCHEDULE EVERY 1 YEAR
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 YEAR
DO
UPDATE Player SET age=age+1;

