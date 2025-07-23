CREATE OR REPLACE FUNCTION update_work_rating()
RETURNS TRIGGER AS $$
DECLARE
    v_work_id INTEGER;
BEGIN
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        SELECT work_id INTO v_work_id FROM editions WHERE id = NEW.edition_id;
    ELSE
        SELECT work_id INTO v_work_id FROM editions WHERE id = OLD.edition_id;
    END IF;

    IF v_work_id IS NOT NULL THEN
        UPDATE works
        SET rating = (
            SELECT AVG(t.rating)
            FROM trackings t
            JOIN editions e ON t.edition_id = e.id
            WHERE e.work_id = v_work_id
        )
        WHERE id = v_work_id;
    END IF;

    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_work_rating
AFTER INSERT OR UPDATE OR DELETE ON trackings
FOR EACH ROW
EXECUTE FUNCTION update_work_rating();