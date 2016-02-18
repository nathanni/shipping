package com.atriumwindows.shipping.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Nathan on 2/17/2016.
 */
@Repository
public class ShippingInfoDao {


    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Transactional(isolation = Isolation.READ_COMMITTED, readOnly = true)
    public String getSalesOrderByTrackingNumber(String trackingNumber) {
        String sql = "SELECT Sales_Order_Number FROM Tracking WHERE Tracking_Number = ?";
        return getStringBySingleParam(trackingNumber, sql);
    }

    @Transactional(isolation = Isolation.READ_COMMITTED, readOnly = true)
    public String getLoadNumberBySalesOrder(String salesOrder) {

        String sql = "SELECT DISTINCT BOL FROM OrderMaster WHERE SalesOrder = ?";

        return getStringBySingleParam(salesOrder, sql);
    }

    @Transactional(isolation = Isolation.READ_COMMITTED, readOnly = true)
    public String getTrackingNumberBySalesOrder(String salesOrder) {
        String sql = "SELECT Tracking_Number FROM Tracking WHERE Sales_Order_Number = ?";

        return getStringBySingleParam(salesOrder, sql);
    }

    @Transactional(isolation = Isolation.READ_COMMITTED, readOnly = true)
    private String getStringBySingleParam(String singleParam, String sql) {
        List<String> strLst = jdbcTemplate.query(sql, new RowMapper<String>() {
            public String mapRow(ResultSet resultSet, int i) throws SQLException {
                return resultSet.getString(1);
            }
        }, singleParam);

        if ( strLst.isEmpty() ){
            return null;
        }else if ( strLst.size() == 1 ) { // list contains exactly 1 element
            return strLst.get(0);
        }else{  // list contains more than 1 elements
            //your wish, you can either throw the exception or return 1st element.
            return strLst.get(0);
        }
    }
}
