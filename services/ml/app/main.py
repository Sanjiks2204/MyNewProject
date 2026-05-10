"""Mechzo Predict — async ML service.

Phase 3 scope: ingest vehicle + service history, return predictive maintenance hints.
This file is a working FastAPI skeleton; the real model is wired in Phase 3.
"""

from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional

app = FastAPI(title="Mechzo Predict", version="0.1.0")


@app.get("/health")
def health():
    return {"status": "ok", "service": "mechzo-ml"}


class VehicleSnapshot(BaseModel):
    vehicle_id: str
    odometer_km: int
    fuel: str
    last_service_at_km: Optional[int] = None
    last_service_days_ago: Optional[int] = None


class Prediction(BaseModel):
    vehicle_id: str
    issues: list[dict]
    confidence: float


@app.post("/predict/maintenance", response_model=Prediction)
def predict_maintenance(snapshot: VehicleSnapshot) -> Prediction:
    # Placeholder heuristic. Real model arrives in Phase 3.
    issues = []
    if snapshot.last_service_at_km is not None:
        delta = snapshot.odometer_km - snapshot.last_service_at_km
        if delta > 8000:
            issues.append({
                "category": "engine_oil",
                "severity": "medium",
                "message": f"You're {delta} km past your last service.",
            })
    if snapshot.last_service_days_ago is not None and snapshot.last_service_days_ago > 180:
        issues.append({
            "category": "general_inspection",
            "severity": "low",
            "message": "It has been over 6 months since the last service.",
        })
    return Prediction(
        vehicle_id=snapshot.vehicle_id,
        issues=issues,
        confidence=0.5 if issues else 0.95,
    )
