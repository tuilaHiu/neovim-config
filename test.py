from datetime import datetime, timezone
from typing import Any, List, Optional

from pydantic import BaseModel, Field, field_serializer, field_validator


class DateTimeAwareModel(BaseModel):
    """Shared logic to ensure datetime fields default to UTC if naive."""

    @staticmethod
    def _normalize_datetime(value: Any) -> Any:
        if value is None:
            return value

        if isinstance(value, str):
            candidate = value.replace("Z", "+00:00")
            try:
                parsed = datetime.fromisoformat(candidate)
            except ValueError:
                # Let Pydantic handle invalid strings later.
                return value
        elif isinstance(value, datetime):
            parsed = value
        else:
            return value

        if parsed.tzinfo is None:
            parsed = parsed.replace(tzinfo=timezone.utc)

        return parsed.isoformat()

    @field_validator("start_time", "end_time", mode="before", check_fields=False)
    @classmethod
    def _ensure_datetime_timezone(cls, value: Any) -> Any:
        return cls._normalize_datetime(value)

    @field_serializer("start_time", "end_time", when_used="json", check_fields=False)
    def _serialize_datetime(cls, value: Any) -> Any:
        return cls._normalize_datetime(value)


class OHLCVTimeRequest(DateTimeAwareModel):
    symbol: str = Field(
        ...,
        description="Trading symbol (e.g., 'BTCUSDT')",
        example="BTCUSDT",
    )
    exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: str = Field(
        default="spot",
        description="Contract type: 'spot', 'usdm', or 'coinm'",
        example="usdm",
    )
    interval: str = Field(
        default="1d",  
        description="Time interval (22m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 8h, 12h, 1d, 3d, 1w, 15m)",
        example="1d", 
    )  
    start_time: Optional[str] = Field( 
        default=None, 
        description="Start time in ISO format (e.g., '2020-10-01T00:00:00'). If None, defaults to '2020-01-01T00:00:00+07:00'",
        example="2025-10-01T00:00:00", 
    )
    end_time: Optional[str] = Field( 
        default=None,
        description="End time in ISO format. If None or > now, defaults to current time",
        example="2026-11-02T00:00:00",
    )


class LiveOHLCVRequest(DateTimeAwareModel):
    symbol: str = Field(
        ...,
        description="Trading symbol (e.g., 'BTCUSDT')",
        example="BTCUSDT",
    )
    exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: str = Field(
        default="usdm",
        description="Contract type: 'spot', 'usdm', or 'coinm'",
        example="usdm",
    )
    interval: str = Field(
        default="1d",  
        description="Time interval",   
        example="1d", 
    )  
    limit: int = Field( 
        default=100, 
        description="Maximum number of records to return",
        example=100, 
    )
 

class MultipleSymbolsTimeRequest(DateTimeAwareModel):
    symbols: List[str] = Field(
        ...,
        description="List of trading symbols",
        example=["BTCUSDT", "ETHUSDT"],
    )
    exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: str = Field(
        default="spot",
        description="Contract type",
        example="usdm",
    )
    interval: str = Field(
        default="15m",  
        description="Time interval",   
        example="10m", 
    )  
    start_time: Optional[str] = Field( 
        default=None, 
        description="Start time in ISO format",
        example="2020-10-01T00:00:00", 
    )
    end_time: Optional[str] = Field( 
        default=None,
        description="End time in ISO format",
        example="2026-11-02T00:00:00",
    )


class MultipleSymbolsLimitRequest(DateTimeAwareModel):
    symbols: List[str] = Field(
        ...,
        description="List of trading symbols",
        example=["BTCUSDT", "ETHUSDT"],
    )
    exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: str = Field(
        default="spot",
        description="Contract type",
        example="usdm",
    )
    interval: str = Field(
        default="15m",  
        description="Time interval",   
        example="10m", 
    )  
    limit: int = Field( 
        default=100000, 
        description="Maximum number of records per symbol",
        example=10000000, 
    )
 

class SymbolInfoRequest(DateTimeAwareModel):
    exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: Optional[str] = Field(
        default=None,
        description="Contract type filter. If None, returns all contract types",
        example="usdm",
    )


class ContractTypeRequest(DateTimeAwareModel):
    contract_type: str = Field(
        ...,
        description="Contract type: 'spot', 'usdm', or 'coinm'",
        example="spot",
    )


class FundingRateTimeRequest(DateTimeAwareModel):
    symbol: str = Field(
        ...,
        description="Trading symbol (e.g., 'BTCUSDT')",
        example="BTCUSDT",
    )
    exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: str = Field(
        default="usdm",
        description="Contract type: 'usdm' or 'coinm'",
        example="usdm",
    )
    start_time: Optional[str] = Field(
        default=None,
        description="Start time in ISO format",
        example="2020-10-01T00:00:00",
    )
    end_time: Optional[str] = Field(
        default=None,
        description="End time in ISO format",
        example="2026-11-02T00:00:00",
    )


class LatestFundingRequest(DateTimeAwareModel):
    symbol: str = Field(
        ...,
        description="Trading symbol (e.g., 'BTCUSDT')",
        example="BTCUSDT",
    )
exchange: str = Field(
        default="binance",
        description="Exchange name",
        example="binance",
    )
    contract_type: str = Field(
        default="usdm",
        description="Contract type: 'usdm' or 'coinm'",
        example="usdm",
    )

__all__ = [
    "ContractTypeRequest",
    "DateTimeAwareModel",
    "FundingRateTimeRequest",
    "LatestFundingRequest",
    "LiveOHLCVRequest",
    "MultipleSymbolsLimitRequest",
    "MultipleSymbolsTimeRequest",
    "OHLCVTimeRequest",
    "SymbolInfoRequest",
]

