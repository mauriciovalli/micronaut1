package micronaut1;

import io.micronaut.http.HttpResponse;
import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;

@Controller("/api/v1/micronaut")
public class HelloController {

    @Get(value = "/hello", produces = MediaType.APPLICATION_JSON)
    public HttpResponse<Gretting> hello() {
        return HttpResponse.ok(Gretting.builder().action("Hello").build());
    }
}
