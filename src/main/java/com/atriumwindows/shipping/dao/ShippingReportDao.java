package com.atriumwindows.shipping.dao;

import com.atriumwindows.shipping.bean.ShippingReport;
import com.atriumwindows.shipping.bean.ShippingReportLine;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by nni on 2/18/2016.
 */
@Repository
public class ShippingReportDao extends BaseDao {

    public List<String> getShippingReportList(String loadNumber) {
        String sql = "SELECT sales_order_number FROM DTS_PLAN_HEADER d " +
                "WHERE to_date(d.so_create_date,'yyyy-mm-dd') >  Add_months(SYSDATE, -12) " +
                "AND d.assigned_load = ?";

        return jdbcTemplate.query(sql, new RowMapper<String>() {
            public String mapRow(ResultSet resultSet, int i) throws SQLException {
                return resultSet.getString(1);
            }
        }, loadNumber);

    }

    public ShippingReport getShippingReport(String salesOrder) {

        ShippingReport shippingReport;
        String sql = " SELECT om.salesorder salesOrder," +
                "       c.accountid accountId," +
                "       c.account_name accountName," +
                "       To_char(om.cutoffdate, 'Day') cutOffDay," +
                "       To_char(om.dateproofed, 'MONTH DD, YYYY') orderDate," +
                "       To_char(om.duedate, 'MONTH DD, YYYY') dueDate," +
                "       om.shipcode shipCode," +
                "       s.shipcodedesc shipCodeDesc," +
                "       om.orderid orderId," +
                "       om.namejob jobName," +
                "       om.purchaseorder purchaseOrder," +
                "       om.shipname shipName," +
                "       c.address1 billAddress1," +
                "       om.shipstreet1 shipStreet1," +
                "       c.address2 billAddress2," +
                "       om.shipstreet2 shipStree2," +
                "       om.shipcity shipCity," +
                "       c.city billCity," +
                "       om.shipstate shipState," +
                "       c.state billState," +
                "       a.planregion regionCode," +
                "       a.route routeCode," +
                "       om.shipzip shipZip," +
                "       c.postal_code billZip" +
                " FROM   ordermaster om" +
                "       join address c" +
                "         ON om.accountid = c.accountid" +
                "       join accountsmaster a" +
                "         ON a.accountid = c.accountid" +
                "      join shipcode s" +
                "   ON om.shipcode = s.shipcode " +
                " WHERE  om.salesorder = ?" +
                "       AND c.shipid = om.shipid" +
                "       AND dateproofed > Add_months(SYSDATE, -12) ORDER BY OrderId DESC";

        shippingReport = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<ShippingReport>(ShippingReport.class), salesOrder);
        shippingReport.setShippingLines(getShippingReportLines(shippingReport.getOrderId()));
        return shippingReport;
    }

    public List<ShippingReportLine> getShippingReportLines(String orderId) {
        String sql = "SELECT l1.Quantity quantity, l2.Description description, l2.ProductionText productionText, " +
                "l2.GlassText glassText, l2.PartNumberExact partNumber, " +
                "l2.extendedpartnumber extentedPartNumber, l2.infopartnumber infoPartNumber " +
                "FROM L1_Item l1 JOIN L2_Unit l2 ON l2.ItemId = l1.ItemId WHERE " +
                "OrderId = ? ORDER BY l1.ItemId";

        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<ShippingReportLine>(ShippingReportLine.class), orderId);
    }

}
