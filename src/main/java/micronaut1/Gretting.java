package micronaut1;

import io.micronaut.core.annotation.Introspected;
import lombok.Builder;
import lombok.Data;

@Introspected
@Builder
@Data
public class Gretting {
    private String action;
}