# MySQL-ELK-mini-project

## 🌍 프로젝트 개요 
본 프로젝트는 Ubuntu 환경에서 Logstash를 활용해 MySQL과 ElasticSearch를 연동하고, Kibana를 활용한 시각화를 통해 나라별 빅맥 지수와 최저 임금, 관광 데이터 간의 유의미한 인사이트 도출을 목표로 합니다. 


### 주제 


- 🍔 빅맥 지수(Big Mac index)란?
  - 전 세계 각국의 맥도날드 매장에서 팔리는 빅맥 가격을 달러로 환산한 가격
  - 환율의 적정 수준을 평가하는 간편한 방법 혹은 각국의 물가를 비교하는 참고 자료로 사용 

## 🛠️ 개발구성원 
<table>
  <tbody>
    <tr>
      <td align="center">
         <a href="https://github.com/yeejkim">
          <img src="https://github.com/yeejkim.png" width="200px;" alt=""/>
          <br /><sub><b> 김예진 </b></sub>
        </a>
        <br />
      </td>
      <td align="center">
          <a href="https://github.com/HyunDooBoo">
          <img src="https://github.com/HyunDooBoo.png" width="200px;" alt=""/>
          <br /><sub><b> 오현두 </b></sub>
        </a>
        <br />
      </td>
      <td align="center">
        <a href="https://github.com/imhaeunim">
          <img src="https://github.com/imhaeunim.png" width="200px;" alt=""/>
          <br /><sub><b> 임하은 </b></sub>
        </a>
        <br />
      </td>
      <td align="center">
        <a href="https://github.com/BlueRedOrange">
          <img src="https://github.com/BlueRedOrange.png" width="200px;" alt=""/>
          <br /><sub><b> 정파란 </b></sub>
        </a>
        <br />
      </td>
    </tr>
  </tbody>
</table>

## 🛠️ 사용 기술 스택 
- **데이터베이스:** MySQL
- **동기화 도구:** Logstash (JDBC Driver 활용)
- **검색 및 분석 엔진:** ElasticSearch
- **시각화 도구:** Kibana
- **언어:** SQL, JSON
- **자동화 도구:** Logstash 스케줄링

## 🗂️ 데이터
### 활용 데이터셋 
1. [Big Mac Index Data](https://www.kaggle.com/datasets/mrmorj/big-mac-index-data)
  - 각국의 맥도날드에서 제공하는 빅맥 가격과 전 세계의 보고서를 기반으로 구성된 데이터셋

| 컬럼명 | 설명 |
|:---:|:---:|
| date | 날짜 |
| iso_a3 | 국가의 3자리 ISO 국가 코드 |
| currency_code | 해당 국가의 통화 코드 |
| name | 국가명 |
| local_price | 해당 국가에서의 빅맥 가격 (현지 통화 기준) |
| dollar_ex | 해당 국가 통화와 미국 달러 간의 환율 |
| dollar_price | 미국 달러 기준의 빅맥 가격 |
| USD_raw | 원래 미국 달러 가격 (원가) |
| EUR_raw | 원래 유로 가격 (원가) |
| GBP_raw | 원래 파운드 가격 (원가) |
| JPY_raw | 원래 엔 가격 (원가) |
| CNY_raw | 원래 위안 가격 (원가) |
| GDP_dollar | 해당 국가의 GDP (미국 달러 기준) |
| adj_price | 조정된 가격 (환율 변동 등을 반영한 가격) |
| USD_adjusted | 조정된 USD 가격 |
| EUR_adjusted | 조정된 EUR 가격 |
| GBP_adjusted | 조정된 GBP 가격 |
| JPY_adjusted | 조정된 JPY 가격 |
| CNY_adjusted | 조정된 CNY 가격 |
    



2. [Minimum Wages between 2001 & 2018](https://www.kaggle.com/datasets/frtgnn/minimum-wages-between-2001-2018)
  - 각국의 2001년부터 2018년 사이의 최저 임금 데이터셋 

| 컬럼명 | 설명 |
|:---:|:---:|
| year | 날짜 |
| country | 나라명 |
| money | 최저 임금  |


| Country   | 2001   | 2002   | 2003   | 2004   | 2005   |
|-----------|--------|--------|--------|--------|--------|
| Australia | 20664.4| 20867.9| 21140.2| 21511.3| 21685.7|
| Belgium   | 21651.3| 21941.5| 21814.6| 21578.3| 21413.6|
| Canada    | 14205.3| 14056.0| 13858.6| 13880.8| 14002.8|
| Chile     | 4507.9 | 4637.8 | 4701.6 | 4833.0 | 4925.8 |


3. [세계관광지표](https://know.tour.go.kr/stat/worldTourStatSummaryDis19Re.do)
  - 156개국을 대상으로 UN Tourism의 여행객수, 관광수입 및 관광지출 데이터셋 

| 컬럼명 | 설명 |
|:---:|:---:|
| year | 연도 |
| country | 나라명 |
| 여행객수 | 특정 연도에 방문한 여행객 수 |
| 관광수입 | 해당 국가의 관광 수입 |
| 관광지출 | 해당 국가의 관광 지출 |


| 구분                    | 2002년 | 2003년 | 2004년 | 2005년 |
|-------------------------|--------|--------|--------|--------|
| 세계(World)             | 709    | 697    | 761    | 809    |
| 유럽(Europe)            | 407.4  | 408.6  | 420.8  | 452.9  |
| 북유럽(Northern Europe) | 43.8   | 44.5   | 47.4   | 54.9   |
| 덴마크(Denmark)         | 2      | 3.5    | 4.4    | 9.2    |


### 데이터 전처리 
- 문제 상황 
  - 위 2, 3번 데이터셋의 경우, **교차 테이블(Cross-Tabulation Table)** 형식으로 이루어져 있었음


- 데이터 전처리 
  - 행지향(Row-oriented) 방식으로 변경

<details><summary>코드</summary>

```python
# 관련된 행에서 연도 정보 추출
arrival_years = data.iloc[0, 2:21].values  # C부터 U 열까지
income_years = data.iloc[0, 21:40].values  # V부터 AN 열까지
expenditure_years = data.iloc[0, 40:59].values  # AO부터 BG 열까지

# 관광객수, 수입, 지출 데이터 추출
arrival_data = data.iloc[1:, 2:21]  # 2행부터 21열까지
income_data = data.iloc[1:, 21:40]  # 2행부터 40열까지
expenditure_data = data.iloc[1:, 40:59]  # 2행부터 59열까지

# 국가 이름이 제대로 설정되도록 함
arrival_data['country'] = data.iloc[1:, 1].values  # 국가 이름이 있는 열
income_data['country'] = data.iloc[1:, 1].values
expenditure_data['country'] = data.iloc[1:, 1].values

# 각 데이터를 long format으로 변환
arrival_long = arrival_data.melt(id_vars=['country'], var_name='year', value_name='visitors')  # 방문객수 데이터
income_long = income_data.melt(id_vars=['country'], var_name='year', value_name='income')  # 수입 데이터
expenditure_long = expenditure_data.melt(id_vars=['country'], var_name='year', value_name='outcome')  # 지출 데이터

# 모든 데이터를 병합
data_merged = pd.merge(arrival_long, income_long, on=['country', 'year'], how='outer')
data_merged = pd.merge(data_merged, expenditure_long, on=['country', 'year'], how='outer')

# 정리된 데이터를 CSV 파일로 저장
output_path = 'tourism_data.csv'
data_merged.to_csv(output_path, index=False)

```
</details> 

   
  
  - 각국의 이름과 연도 기준으로 하나의 테이블로 병합
 
  




### 최종 데이터셋 

| 칼럼명           | 설명                                      |
|------------------|-------------------------------------------|
| date             | 데이터가 기록된 날짜                      |
| iso_a3           | 국가의 ISO 3166-1 Alpha-3 코드 (3자리 국가 코드) |
| currency_code    | 국가의 통화 코드                          |
| name             | 국가 또는 지역의 이름                     |
| local_price      | 해당 국가에서의 현지 가격                 |
| dollar_ex        | 해당 국가의 달러 환율                     |
| dollar_price     | 달러 기준의 가격                          |
| USD_raw          | 미국 달러로 변환한 원시 가격               |
| EUR_raw          | 유로로 변환한 원시 가격                    |
| GBP_raw          | 영국 파운드로 변환한 원시 가격             |
| JPY_raw          | 일본 엔으로 변환한 원시 가격               |
| CNY_raw          | 중국 위안화로 변환한 원시 가격             |
| GDP_dollar       | 해당 국가의 GDP (미국 달러 기준)           |
| adj_price        | 가격 조정 후 현지 가격                     |
| USD_adjusted     | 달러로 조정된 가격                         |
| EUR_adjusted     | 유로로 조정된 가격                         |
| GBP_adjusted     | 영국 파운드로 조정된 가격                  |
| JPY_adjusted     | 일본 엔으로 조정된 가격                    |
| CNY_adjusted     | 중국 위안화로 조정된 가격                  |
| min_wage         | 최저 임금                                  |
| visitors         | 해당 국가를 방문한 여행객 수 (백만명 기준) |
| income           | 관광 수입                                  |
| outcome          | 관광 지출                                  |


| date       | iso_a3 | currency_code | name        | local_price | dollar_ex | dollar_price | USD_raw  | EUR_raw  | GBP_raw  | JPY_raw  | CNY_raw  | GDP_dollar | adj_price | USD_adjusted | EUR_adjusted | GBP_adjusted | JPY_adjusted | CNY_adjusted | min_wage | visitors | income | outcome |
|------------|--------|---------------|-------------|-------------|-----------|--------------|----------|----------|----------|----------|----------|------------|-----------|--------------|--------------|--------------|--------------|--------------|----------|----------|--------|---------|
| 2000-04-01 | ARG    | ARS           | Argentina   | 2.5         | 1         | 2.5          | -0.00398 | 0.05007  | -0.16722 | -0.09864 | 1.09091  | 50000      | 2.6       | 2.4          | 2.3          | 2.5          | 2.7          | 2.6          | 450      | 15       | 2000   | 1500    |
| 2000-04-01 | AUS    | AUD           | Australia   | 2.59        | 1.68      | 1.541666667  | -0.38579 | -0.35246 | -0.48645 | -0.44416 | 0.28939  | 100000     | 2.8       | 2.7          | 2.9          | 3.0          | 3.1          | 2.9          | 1800     | 20       | 2500   | 2000    |
| 2000-04-01 | BRA    | BRL           | Brazil      | 2.95        | 1.79      | 1.648044693  | -0.34341 | -0.30778 | -0.45102 | -0.40581 | 0.37836  | 70000      | 3.0       | 2.9          | 3.1          | 3.2          | 3.3          | 3.1          | 500      | 18       | 2200   | 1800    |
| 2000-04-01 | CAN    | CAD           | Canada      | 2.85        | 1.47      | 1.93877551   | -0.22758 | -0.18566 | -0.35417 | -0.30099 | 0.62152  | 80000      | 2.7       | 2.6          | 2.8          | 2.9          | 3.0          | 2.8          | 1500     | 25       | 3000   | 2500    |
| 2000-04-01 | CHE    | CHF           | Switzerland | 5.9         | 1.7       | 3.470588235  | 0.3827   | 0.45774  | 0.15609  | 0.2513   | 1.90267  | 120000     | 3.5       | 3.3          | 3.6          | 3.7          | 3.8          | 3.6          | 3500     | 30       | 4000   | 3500    |




## 🚀 설계

### 아키텍처 
![Flowcharts](https://github.com/user-attachments/assets/200c513a-145e-4577-abb4-b5318bf16903)



1. **데이터 저장:** MySQL 데이터베이스에 최종 데이터셋 csv 파일 import 
2. **Logstash 동기화:** Logstash의 JDBC 드라이버를 통해 MySQL에서 ES로 데이터를 1분 간격으로 스케쥴링 자동화
    <details>
    <summary>conf 파일 설정</summary>
    
    - **입력(Input):** MySQL 데이터베이스에서 데이터를 가져오는 JDBC 설정
    - **필터(Filter):** 필요한 데이터만 추출하고 가공
    - **출력(Output):** ElasticSearch로 데이터 전송
  
    ```plaintext
    input {
      jdbc {
        jdbc_connection_string => "jdbc:mysql://localhost:3306/bigmac_db"
        jdbc_user => "root"
        jdbc_password => "password"
        jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
        schedule => "* * * * *"
        statement => "SELECT * FROM bigmac_table WHERE timestamp > :sql_last_value"
        use_column_value => true
        tracking_column => "timestamp"
      }
    }
    
    output {
      elasticsearch {
        hosts => ["http://localhost:9200"]
        index => "bigmac_index"
      }
    }
    ```
    
    - 스케줄링 설정
      - Logstash는 `schedule` 옵션을 사용하여 1분마다 데이터를 동기화합니다.
    <details>
    <summary>conf 파일 설정</summary>
    


3. **데이터 시각화:** Kibana 통한 데이터 시각화 및 인사이트 도출


## 📝 디렉토리 구조
```
├── logstash_config/
│   └── big_mac_unix.conf
│   └── big_mac_interval.conf
│   └── big_mac_convert_tz.conf
├── sql_scripts/
│   └── create_bigmac_table.sql
├── data/
│   └── bid_mac_wage_tour.csv
└── README.md
```


## 🐞 트러블슈팅 

### 문제 1: 데이터베이스와 연결 오류
- **문제**: MySQL 계정으로 데이터를 Logstash를 통해 Elasticsearch로 전송 실패

- **원인**: root 계정은 모든 권한을 다 가지고 있으나, 다른 프로그램과 연결시에 보안 상의 문제로 연결이 되지 않음 

### 해결 방법
- 새로운 사용자(user01)을 생성하여 권한 부여 후, 연결 진행
<details>
<summary>MySQL 사용자 생성 및 권한 부여 SQL</summary>

```sql
CREATE USER 'user01'@'%' IDENTIFIED BY 'user01';
GRANT SELECT ON your_database.* TO 'user01'@'%';
FLUSH PRIVILEGES;
```
</details>

### 문제 2
- **문제**: `timestamp`를 기준으로 데이터를 동기화하려 했으나, `sql_last_value`가 제대로 작동하지 않음
- **원인**: MySQL의 `timestamp` 데이터 유형이 ES의 형식과 일치하지 않아 데이터 동기화 실패 

### 해결 방법
1. `timestamp` 데이터를 `datetime` 형식으로 변환
2. Logstash 설정에서 `tracking_column_type`을 명시적으로 추가

<details>
<summary>Logstash 설정</summary>
```plaintext
tracking_column_type => "timestamp"
```
</details>

3. ElasticSearch에서 매핑을 수정하여 `timestamp` 형식을 지원하도록 설정



## 🌟 결과물 
### Kibana 시각화
![Kibana 시각화](image.png)

- 위와 같은 그래프를 통해 국가별 한 달 동안 일해서 구매 가능한 빅맥의 개수를 비교할 수 있습니다.
- 이러한 데이터는 국가 간 경제력을 비교하거나 소비 수준을 분석하는 데 유용합니다.





## 🧐회고
- 김예진
- 오현두
- 임하은
- 정파란



## 📚 참고 자료 
- [ElasticSearch 공식 문서](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Logstash JDBC Input Plugin](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html)
- [빅맥 지수 위키백과](https://en.wikipedia.org/wiki/Big_Mac_Index)

