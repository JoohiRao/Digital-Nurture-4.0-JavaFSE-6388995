package com.cognizant.getcountry.controller;

import com.cognizant.getcountry.model.Country;
import com.cognizant.getcountry.service.CountryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class CountryController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CountryController.class);

    @Autowired
    private CountryService countryService;

    @GetMapping("/country/{code}")
    public Country getCountry(@PathVariable String code) {
        LOGGER.debug("START - getCountry()");
        Country country = countryService.getCountry(code);
        LOGGER.debug("END - getCountry()");
        return country;
    }
}
