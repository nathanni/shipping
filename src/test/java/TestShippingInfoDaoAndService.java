import com.atriumwindows.shipping.service.ShippingInfoService;
import org.junit.Test;

/**
 * Created by Nathan on 2/17/2016.
 */
public class TestShippingInfoDaoAndService extends TestBase {


    private ShippingInfoService shippingInfoService;

    @Test
    public void test() {

        shippingInfoService = (ShippingInfoService) applicationContext.getBean("shippingInfoService");
        System.out.println(shippingInfoService.getLoadNumberBySalesOrder("00972801"));
        System.out.println(shippingInfoService.getTrackingNumberBySalesOrder("01764595"));
        System.out.println(shippingInfoService.getSalesOrderByTrackingNumber("1Z6369220341385280"));

    }


}
