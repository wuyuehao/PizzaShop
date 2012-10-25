// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tony.pizza.domain;

import com.tony.pizza.domain.Topping;
import com.tony.pizza.domain.ToppingDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect ToppingDataOnDemand_Roo_DataOnDemand {
    
    declare @type: ToppingDataOnDemand: @Component;
    
    private Random ToppingDataOnDemand.rnd = new SecureRandom();
    
    private List<Topping> ToppingDataOnDemand.data;
    
    public Topping ToppingDataOnDemand.getNewTransientTopping(int index) {
        Topping obj = new Topping();
        setName(obj, index);
        return obj;
    }
    
    public void ToppingDataOnDemand.setName(Topping obj, int index) {
        String name = "name_" + index;
        obj.setName(name);
    }
    
    public Topping ToppingDataOnDemand.getSpecificTopping(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Topping obj = data.get(index);
        Long id = obj.getId();
        return Topping.findTopping(id);
    }
    
    public Topping ToppingDataOnDemand.getRandomTopping() {
        init();
        Topping obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Topping.findTopping(id);
    }
    
    public boolean ToppingDataOnDemand.modifyTopping(Topping obj) {
        return false;
    }
    
    public void ToppingDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Topping.findToppingEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Topping' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Topping>();
        for (int i = 0; i < 10; i++) {
            Topping obj = getNewTransientTopping(i);
            try {
                obj.persist();
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
