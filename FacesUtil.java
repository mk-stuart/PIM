
import java.io.IOException;
import java.io.Serializable;
import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author luis
 */
public abstract class FacesUtil  {

    private ResourceBundle bundle;

    public void warn(String message) {
        warn(null, message);
    }

    public void warn(String clientId, String i18n) {
        // Pega a mensagem de acordo com a chave
        String message = bundle.getString(i18n);
        FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_WARN,
                message, null);
        FacesContext.getCurrentInstance().addMessage(clientId, msg);
    }

    public void error(String i18n) {
        error(null, i18n);
    }

    public void error(String clientId, String i18n) {

        // Pega a mensagem de acordo com a chave
        String message = bundle.getString(i18n);

        FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_ERROR,
                message, null);
        FacesContext.getCurrentInstance().addMessage(clientId, msg);
    }

    public void info(String i18n) {
        info(null, i18n,null);
    }

    public void info(String i18n, Object[] params) {
        info(null, i18n, params);
    }

    public void info(String clientId, String i18n,Object[] params) {

        // Pega a mensagem de acordo com a chave
        String message = bundle.getString(i18n);
        if(params!=null && params.length > 0){
            MessageFormat mf = new  MessageFormat(message);
            message = mf.format(params, new StringBuffer(), null).toString();
        }
        
        FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_INFO,
                message, null);
        FacesContext.getCurrentInstance().addMessage(clientId, msg);
    }

    public void redirect(String url) {
        try {
            FacesContext.getCurrentInstance().getExternalContext().
                    redirect(url);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    @PostConstruct
    public void onConstruct() {
        Locale locale = FacesContext.getCurrentInstance().getViewRoot().getLocale();
        // Pega o bundle de acordo com o locale
        bundle = ResourceBundle.getBundle(
                FacesContext.getCurrentInstance().getApplication().
                getMessageBundle(), locale);
        postConstruct();
    }
}
