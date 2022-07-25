package com.laptrinhjavaweb.buildingenum;

public  enum TransactionEnum {
    QUA_TRINH_CSKH ("Quá trình chăm sóc khách hàng"),
    DAN_DI_XEM ("Dẫn đi xem");

    private final String value;

    public String getValue() {
        return value;
    }

    private TransactionEnum(String value) {
        this.value = value;
    }
}
