import com.atriumwindows.shipping.service.ShippingReportService;
import org.junit.Test;

/**
 * Created by nni on 2/18/2016.
 */
public class TestShippingReportDaoAndService extends TestBase{

    @Test
    public void test() {

        ShippingReportService shippingReportService = (ShippingReportService) applicationContext.getBean("shippingReportService");
        //System.out.println(shippingReportService.getShippingReportList("99999"));
        System.out.println(shippingReportService.getShippingReport("06722715"));
        //System.out.println(shippingReportService.getShippingReportLines("7806229"));

    }
}
