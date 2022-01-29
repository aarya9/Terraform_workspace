variable "app_name"{
    type=object({
        default = string
        dev=string
        test=string 
    })
    default={
        default="appdefault"
        dev="appdev"
        test="apptest"
    }
}

variable "app_domain"{
    type=object({
        default =string
        dev=string
        test=string 
    })
    default={
        default="dfdom"
        dev="devdom"
        test="testdom"
    }
}

variable "app_environment"{
    type=object({
        default = string
        dev=string
        test=string 
    })
    default={
        default="envdefault"
        dev="envdev"
        test="envtest"
    }
}