package com.baseapi.myrestapi;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class MyRestApiApplicationTests {

	// Default contextLoads test crashes without a valid database connection
    // See https://stackoverflow.com/questions/74039798/how-to-have-a-database-connection-without-failing-unit-tests-with-spring-boot
	/*@Test
	void contextLoads() {
	}*/

}
