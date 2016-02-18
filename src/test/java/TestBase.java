import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by Nathan on 2/17/2016.
 */
public class TestBase {



    protected ApplicationContext applicationContext;

    TestBase() {

         applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
    }
}
