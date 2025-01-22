# ElasticSearch와 MySQL 연동 프로젝트: 빅맥 지수 시각화

## 🌍 프로젝트 개요 
이 프로젝트는 MySQL 데이터베이스에 저장된 데이터를 Logstash를 활용하여 ElasticSearch(이하 ES)로 동기화하고, Kibana를 통해 국가별 유의미한 데이터를 시각화하는 것을 목표로 합니다. 데이터는 빅맥 지수를 기반으로 하며, ~ 인사이트를 제공합니다.

## 아이템 선정 이유
- **데이터의 중요성:** 빅맥 지수는 단순하지만 국가 간 경제 격차를 이해하는 데 효과적입니다.
- **기술적 도전:** MySQL, Logstash, ElasticSearch, Kibana를 연동하여 실시간 데이터 동기화를 구현하는 경험.

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

## 🗂️ 데이터 구성 
### 데이터 설명
- **데이터 출처:** 빅맥 지수 관련 데이터
- **주요 컬럼:**
  - `country`: 국가 이름
  - `min_wage`: 최저임금
  - `big_mac_price`: 빅맥 가격
  - `monthly_big_mac_count`: 한 달 일해서 구매 가능한 빅맥의 개수

### 예시 데이터
| 국가    | 최저임금($) | 빅맥 가격($) | 한 달 빅맥 개수 |
|---------|------------|--------------|-----------------|
| 대한민국 | 1,200       | 4.50         | 266             |
| 미국     | 1,500       | 5.00         | 300             |
| 일본     | 1,000       | 4.00         | 250             |

## 🚀 프로젝트 시나리오 
1. **데이터 저장:** MySQL 데이터베이스에 빅맥 지수 데이터를 저장합니다.
2. **Logstash 동기화:** Logstash의 JDBC 드라이버를 통해 MySQL에서 ES로 데이터를 1분 간격으로 동기화합니다.
3. **데이터 시각화:** Kibana를 통해 “국가별 한 달 일해서 구매 가능한 빅맥의 개수”를 시각화합니다.

## ⚙️ 자동화 설정 
### Logstash 설정 파일 (conf)
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

### 스케줄링 설정
- Logstash는 `schedule` 옵션을 사용하여 1분마다 데이터를 동기화합니다.

## 🐞 트러블슈팅 
### 문제 상황
- **문제:** `timestamp`를 기준으로 데이터를 동기화하려 했으나, `sql_last_value`가 제대로 작동하지 않았습니다.
- **원인:** MySQL의 `timestamp` 데이터 유형이 ES의 형식과 일치하지 않아 데이터 동기화가 실패.

### 해결 방법
1. `timestamp` 데이터를 `datetime` 형식으로 변환.
2. Logstash 설정에서 `tracking_column_type`을 명시적으로 추가:

```plaintext
tracking_column_type => "timestamp"
```

3. ElasticSearch에서 매핑을 수정하여 `timestamp` 형식을 지원하도록 설정.

## 🌟 결과물 
### Kibana 시각화
![Kibana 시각화](image.png)

- 위와 같은 그래프를 통해 국가별 한 달 동안 일해서 구매 가능한 빅맥의 개수를 비교할 수 있습니다.
- 이러한 데이터는 국가 간 경제력을 비교하거나 소비 수준을 분석하는 데 유용합니다.


## 📝 디렉토리 구조
```
├── logstash_config/
│   └── logstash.conf
├── sql_scripts/
│   └── create_bigmac_table.sql
├── elasticsearch_mappings/
│   └── bigmac_mapping.json
├── kibana_visualizations/
│   └── bigmac_dashboard.ndjson
└── README.md
```


## 📚 참고 자료 
- [ElasticSearch 공식 문서](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Logstash JDBC Input Plugin](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html)
- [빅맥 지수 위키백과](https://en.wikipedia.org/wiki/Big_Mac_Index)


## 🧐회고
이 프로젝트를 통해 데이터의 가치를 시각적으로 표현하고, 기술적 도전을 해결하는 과정을 배울 수 있었습니다. 🚀

