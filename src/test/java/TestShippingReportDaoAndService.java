import com.atriumwindows.shipping.dao.ShippingReportDao;
import com.atriumwindows.shipping.service.ShippingReportService;
import org.junit.Test;

/**
 * Created by nni on 2/18/2016.
 */
public class TestShippingReportDaoAndService extends TestBase{

    @Test
    public void test() {

        ShippingReportService shippingReportService = (ShippingReportService) applicationContext.getBean("shippingReportService");
        ShippingReportDao shippingReportDao = (ShippingReportDao) applicationContext.getBean("shippingReportDao");
        //System.out.println(shippingReportService.getShippingReportList("99999"));
        //System.out.println(shippingReportService.getShippingReport("07245126"));

        //System.out.println(shippingReportService.getShippingReportForSubOrder("A4689562"));


    }

    @Test
    public void testReg() {
//        String s1 = "C0A70543014";
//        String s2 = s1.replaceFirst("^[AB]","0");
//        System.out.println(s2);
        String str = "A12432700318SA";
        System.out.println(str.matches("^[AB]{1}\\d+"));
    }


}
