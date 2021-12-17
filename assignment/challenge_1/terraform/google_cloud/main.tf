module "vpc" {
  source = "vpc"
}

module "elb" {
  source          = "./elb"

  public_subnet1  = module.vpc.outputpublicsubnet1
  public_subnet2  = module.vpc.outputpublicsubnet2
  private_subnet3 = module.vpc.outputprivatesubnet3
  private_subnet4 = module.vpc.outputprivatesubnet4
  vpc_id          = module.vpc.output_vpc_id
  external_alb_sg = module.vpc.output_external_alb_sg
  internal_alb_sg = module.vpc.output_internal_alb_sg


}

module "asg" {
  source            = "./asg"
  web_launch_config = module.config.web_lc_name
  app_launch_config = module.config.app_lc_name
  public_subnet1    = module.vpc.outputpublicsubnet1
  public_subnet2    = module.vpc.outputpublicsubnet2
  private_subnet3   = module.vpc.outputprivatesubnet3
  private_subnet4   = module.vpc.outputprivatesubnet4
  out_tg_instances  = module.elb.out_tg_instances
  internaltg        = module.elb.internaltg
}

module "config" {
  source                  = "./config"
  output_web_sg           = module.vpc.output_web_sg
  external_alb_sg         = module.vpc.output_external_alb_sg
  output_bastion_ssh      = module.vpc.output_bastion_ssh
  output_internal_alb_sg  = module.vpc.output_internal_alb_sg

}

module "ec2" {
  source                      = "./ec2"
  public_subnet1              = module.vpc.outputpublicsubnet1
  private_subnet3             = module.vpc.outputprivatesubnet3
  private_subnet4             = module.vpc.outputprivatesubnet4
  output_bastion_ssh          = module.vpc.output_bastion_ssh
  web_access_from_nat_prv_sg  = module.vpc.web_access_from_nat_prv_sg
  web_access_from_nat_pub_sg  = module.vpc.web_access_from_nat_pub_sg

}


module "db" {
  source                      = "./db"
  private_subnet3             = module.vpc.outputprivatesubnet3
  private_subnet4             = module.vpc.outputprivatesubnet4
  out_rdssubnetgroup          = module.vpc.out_rdssubnetgroup
  rdsmysqlsg                  = module.vpc.rdsmysqlsg

}