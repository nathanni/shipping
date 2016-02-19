package com.atriumwindows.shipping.dao;

import com.atriumwindows.shipping.bean.ShippingReport;
import com.atriumwindows.shipping.bean.ShippingReportLine;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
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
                "WHERE to_date(d.so_create_date,'yyyy-mm-dd') >  Add_months(SYSDATE, -48) " +
                "AND d.assigned_load = ?";

        return jdbcTemplate.query(sql, new RowMapper<String>() {
            public String mapRow(ResultSet resultSet, int i) throws SQLException {
                return resultSet.getString(1);
            }
        }, loadNumber);

    }


    /*For 0 salesorder*/
    public ShippingReport getShippingReport(String salesOrder) {

        ShippingReport shippingReport;
        String sql = " SELECT om.bol loadNumber," +
                "       om.salesorder salesOrder," +
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
                "       om.shipstreet1 shipAddress1," +
                "       c.address2 billAddress2," +
                "       om.shipstreet2 shipAddress2," +
                "       om.shipcity shipCity," +
                "       c.city billCity," +
                "       om.shipstate shipState," +
                "       c.state billState," +
                "       a.planregion regionCode," +
                "       a.route routeCode," +
                "       om.shipzip shipZip," +
                "       c.postal_code billZip" +
                "       FROM   ordermaster om" +
                "       join address c" +
                "           ON om.accountid = c.accountid" +
                "       join accountsmaster a" +
                "           ON a.accountid = c.accountid" +
                "       join shipcode s" +
                "           ON om.shipcode = s.shipcode " +
                "       WHERE  om.salesorder = ?" +
                "           AND c.shipid = om.shipid";
        try {
            shippingReport = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<ShippingReport>(ShippingReport.class), salesOrder);
        } catch (EmptyResultDataAccessException e) {
            System.out.println("No records found for statement: " + sql);
            return null;
        }

        /* fill the line info*/
        shippingReport.setShippingLines(getShippingReportLines(shippingReport.getOrderId()));

        return shippingReport;
    }

    private List<ShippingReportLine> getShippingReportLines(String orderId) {
        List<ShippingReportLine> list;
        String sql = "SELECT l1.Quantity quantity, l2.Description description, l2.ProductionText productionText, " +
                "l2.GlassText glassText, l2.PartNumberExact partNumber, " +
                "l2.extendedpartnumber extentedPartNumber, l2.infopartnumber infoPartNumber " +
                "FROM L1_Item l1 JOIN L2_Unit l2 ON l2.ItemId = l1.ItemId WHERE " +
                "OrderId = ? ORDER BY l1.ItemId";
        try {
            list = jdbcTemplate.query(sql, new BeanPropertyRowMapper<ShippingReportLine>(ShippingReportLine.class), orderId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
        return list;
    }


    /*For A B Suborders*/
    public ShippingReport getShippingReportForSubOrder(String salesOrder) {
        ShippingReport shippingReport;
        String sql = "SELECT d.assigned_load loadNumber," +
                "      d.sales_order_number salesOrder, " +
                "      c.accountid accountId, " +
                "      c.account_name accountName, " +
                "      d.so_create_date orderDate, " +
                "      d.delivery_date dueDate, " +
                "      d.how_ship shipCode, " +
                "      s.shipcodedesc shipCodeDesc, " +
                "      d.customer_po purchaseOrder, " +
                "      c.address1 billAddress1, " +
                "      c.address2 billAddress2, " +
                "      c.city billCity, " +
                "      c.state billState, " +
                "      a.planregion regionCode, " +
                "      a.route routeCode, " +
                "      c.postal_code billZip " +
                "      FROM dts_plan_header d " +
                "      join address c " +
                "           ON d.customer_code = c.accountid " +
                "      join accountsmaster a " +
                "           ON a.accountid = c.accountid " +
                "      join shipcode s " +
                "           ON d.how_ship = s.shipcode " +
                "      WHERE  d.sales_order_number = ? " +
                "           AND c.shipid = '00'||d .how_ship ";
        try {
            shippingReport = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<ShippingReport>(ShippingReport.class), salesOrder);
        } catch (EmptyResultDataAccessException e) {
            System.out.println("No records found for statement: " + sql);
            return null;
        }

        /* fill missing info from ordermaster*/
        getFieldsInfoFromOrdermaster(shippingReport);

        /* fill the line info*/
        shippingReport.setShippingLines(getShippingReportLinesFromItemids(shippingReport.getSalesOrder(), shippingReport.getLoadNumber()));

        return shippingReport;
    }


    private void getFieldsInfoFromOrdermaster(ShippingReport shippingReport) {
        String salesOrder = shippingReport.getSalesOrder();

        //Replace A or B order to 0 order
        if (salesOrder != null && !salesOrder.isEmpty()) {
            salesOrder = salesOrder.replaceFirst("^[AB]", "0");
        }

        String sql = "SELECT To_char(om.cutoffdate, 'Day') cutOffDay," +
                "       om.orderid orderId, " +
                "       om.namejob jobName, " +
                "       om.shipname shipName, " +
                "       om.shipstreet1 shipAddress1, " +
                "       om.shipstreet2 shipAddress2, " +
                "       om.shipcity shipCity, " +
                "       om.shipstate shipState, " +
                "       om.shipzip shipZip " +
                "       FROM ordermaster om " +
                "       WHERE om.salesorder = ? " +
                "       AND rownum =1";


        try {
            ShippingReport tempShippingReport;
            tempShippingReport = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<ShippingReport>(ShippingReport.class), salesOrder);
            shippingReport.setCutOffDay(tempShippingReport.getCutOffDay());
            shippingReport.setOrderId(tempShippingReport.getOrderId());
            shippingReport.setJobName(tempShippingReport.getJobName());
            shippingReport.setShipName(tempShippingReport.getShipName());
            shippingReport.setShipAddress1(tempShippingReport.getShipAddress1());
            shippingReport.setShipAddress2(tempShippingReport.getShipAddress2());
            shippingReport.setShipCity(tempShippingReport.getShipCity());
            shippingReport.setShipState(tempShippingReport.getShipState());
            shippingReport.setShipZip(tempShippingReport.getShipZip());
        } catch (EmptyResultDataAccessException e) {}


    }


    /* query for detail line infomations using itemid*/
    private List<ShippingReportLine> getShippingReportLinesFromItemids(String salesorder, String loadNumber) {

        List<ShippingReportLine> list = null;
        List<Integer> itemIds = getItemIdsFromPlanDetail(salesorder, loadNumber);

        if (itemIds != null && itemIds.size() != 0) {
            MapSqlParameterSource parameters = new MapSqlParameterSource();
            parameters.addValue("itemids", itemIds);


            String sql = "SELECT l1.Quantity quantity, l2.Description description, l2.ProductionText productionText, " +
                    "l2.GlassText glassText, l2.PartNumberExact partNumber, " +
                    "l2.extendedpartnumber extentedPartNumber, l2.infopartnumber infoPartNumber " +
                    "FROM L1_Item l1 JOIN L2_Unit l2 ON l2.ItemId = l1.ItemId WHERE " +
                    "l1.ItemId IN (:itemids) ORDER BY l1.ItemId";
            try {
                list = namedParameterJdbcTemplate.query(sql, parameters, new BeanPropertyRowMapper<ShippingReportLine>(ShippingReportLine.class));
            } catch (EmptyResultDataAccessException e) {
                return null;
            }
        }

        return list;
    }

    /* Get itemid list from dts_plan_detail*/
    private List<Integer> getItemIdsFromPlanDetail(String salesorder, String loadNumber) {

        List<Integer> itemIds;
        salesorder = salesorder + "%";
        String sql = "SELECT distinct Itemid FROM dts_plan_detail WHERE barcode LIKE ? AND load_number = ? ORDER BY Itemid";

        itemIds = jdbcTemplate.query(sql, new RowMapper<Integer>() {
            public Integer mapRow(ResultSet resultSet, int i) throws SQLException {
                return resultSet.getInt(1);
            }
        }, salesorder, loadNumber);

        return itemIds;

    }


}
