
CREATE TRIGGER sync_campus BEFORE INSERT OR DELETE OR UPDATE ON pantry.campus FOR EACH ROW EXECUTE PROCEDURE pantry.sync_campus();
CREATE TRIGGER sync_kiosk BEFORE INSERT OR DELETE OR UPDATE ON pantry.kiosk FOR EACH ROW EXECUTE PROCEDURE erp.sync_kiosk();
CREATE TRIGGER sync_label_order BEFORE INSERT OR DELETE OR UPDATE ON pantry.label_order FOR EACH ROW EXECUTE PROCEDURE pantry.sync_label_order();
CREATE TRIGGER sync_product BEFORE INSERT OR DELETE OR UPDATE ON pantry.product FOR EACH ROW EXECUTE PROCEDURE erp.sync_product();