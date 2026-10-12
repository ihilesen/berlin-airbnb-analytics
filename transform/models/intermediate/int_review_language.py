from lingua import Language, LanguageDetectorBuilder


def model(dbt, session):
    dbt.config(materialized="table")
    reviews = dbt.ref("int_reviews_clean").df()

    detector = (
        LanguageDetectorBuilder
        .from_languages(Language.ENGLISH, Language.GERMAN, Language.FRENCH,
                        Language.SPANISH, Language.ITALIAN, Language.DUTCH)
        .with_low_accuracy_mode()
        .build()
    )
    texts = reviews["review_text"].fillna("").tolist()
    detected = detector.detect_languages_in_parallel_of(texts)
    reviews["review_language"] = [
        lang.iso_code_639_1.name.lower() if lang else "unknown" for lang in detected
    ]
    return reviews[["review_id", "review_language"]]