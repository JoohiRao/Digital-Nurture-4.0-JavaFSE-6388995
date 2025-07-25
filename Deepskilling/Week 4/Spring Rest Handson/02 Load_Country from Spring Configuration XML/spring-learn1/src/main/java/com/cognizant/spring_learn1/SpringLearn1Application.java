package com.cognizant.spring_learn1;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringLearn1Application {
	private static final Logger LOGGER = LoggerFactory.getLogger(SpringLearn1Application.class);

	public static void main(String[] args) {
		displayCountry();
	}

	public static void displayCountry() {
		ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
		Country country =  context.getBean("country", Country.class);
		LOGGER.debug("Country : {}", country.toString());
	}
}