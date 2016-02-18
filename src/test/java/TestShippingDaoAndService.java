import com.atriumwindows.shipping.service.ShippingService;
import org.junit.Test;

/**
 * Created by Nathan on 2/17/2016.
 */
public class TestShippingDaoAndService extends TestBase {


    private ShippingService shippingInfoService;

    @Test
    public void test() {

        shippingInfoService = (ShippingService) applicationContext.getBean("shippingService");
        System.out.println(shippingInfoService.getLoadNumberBySalesOrder("00972801"));
        System.out.println(shippingInfoService.getTrackingNumberBySalesOrder("01764595"));
        System.out.println(shippingInfoService.getSalesOrderByTrackingNumber("1Z6369220341385280"));

    }


}
